---
title: Using Node.js at GDS
eleventyNavigation:
  parent: Style guides
last_reviewed_on: 2024-04-24
review_in: 12 months
owner_slack: '#nodejs'
permalink: manuals/programming-languages/nodejs/index.html
---

This document describes how we write Node.js code at GDS. It is a list of
guidelines that developers should follow in order to make code more consistent
across all Node.js projects, making it easy for developers to change projects
or start new ones.

## Introduction

The guidance set out here should be followed in conjunction with the advice on
the main [programming languages manual page](../../programming-languages.html).

The advice here is specifically about Node.js. Generic guidelines on writing
code are out of scope.

Most guidelines listed here are recommendations, and the authors acknowledge
that there will sometimes be valid exceptions.

## Node versions

> Only use Long Term Support (<abbr title="Long term support">LTS</abbr>)
versions of Node.js.

These are even-numbered versions (for example, Node.js 18.x or 20.x). However, it is important
to keep an eye on the [Node.js LTS Schedule] as to when versions move in and out
of LTS.

> Do not use the `--harmony`, `--experimental-vm-modules` or other in-progress feature flags

*Staged* or *in-progress* features are not considered stable by the Node implementors.

> Specify the supported version of Node.js in your `package.json`.

Use the [engines](https://docs.npmjs.com/files/package.json#engines) key.

## Source formatting and linting

> Lint your JavaScript code with [StandardJS]

See the general [JavaScript style guide for linting guidance](https://github.com/alphagov/styleguides/blob/master/js.md#linting).

## Project directory structure

> Organise files around features, not roles

The following structure means you don’t require lots of context switching to find related functions and your `require` statements don’t need overly complicated paths.

```
├── product
|   ├── index.js
|   ├── product.js
|   ├── product.spec.js
|   └── product.njk
├── user
|   ├── index.js
|   ├── user.js
|   ├── user.spec.js
|   └── user.njk
```

> Don’t put logic in index.js files

Use these files to `require` all the modules functions.

```js
// product/index.js
const product = require('./product')

module.exports = {
  create: product.create
}
```

> Store test files within the implementation

Keeping tests in the same directory makes them easier to find and more obvious when a test is missing. Keep the project’s global test config and setup scripts in a separate `test` directory.

```
├── test
|   └── setup.spec.js
├── product
|   ├── index.js
|   ├── product.js
|   ├── product.spec.js
|   └── product.njk
```

See also:

- [Node.js Project Structure Tutorial](https://blog.risingstack.com/node-hero-node-js-project-structure-tutorial/) on [Rising Stack](https://blog.risingstack.com/)

## Language constructs

### Declarations

> Use `const` and `let`, avoid `var`

Embrace immutability (more below) and do not let
[hoisting](https://www.adequatelygood.com/JavaScript-Scoping-and-Hoisting.html#declarations_names_and_hoisting)
confuse you.

### Functions

> Prefer `function` for top-level function declarations and `=>` for function literals

```js
// Use:
const foo = function (x) {
  // ...
}

// Avoid:
const foo = x => {
  // ...
}

// Use:
map(item => Math.sqrt(item), array)

// Avoid:
map(function (item) { return Math.sqrt(item) }, array)
```

Acceptable exceptions include single expression functions, such as

```js
const collatz = n => (n % 2) ? (n / 2) : ((3 * n) + 1)
```

or curryied functions, which are more readable using the arrow
notation:

```js
const foo = x => y => z => (x * y) + z
```

Be aware that because anonymous functions do not have a name, a stack trace
will be harder to read when debugging. Also remember that arrow functions keep
their context’s `this`.

### Classes

> Use the `class` keyword to define classes

There are many different ways to define classes in JavaScript. `class` has been added to the standard specifically to resolve this. In short, use `class` for classes and `function` for functions.

```js
class Rectangle {
  constructor (height, width) {
    this.height = height
    this.width = width
  }

  area () {
    return this.width * this.height
  }
}
```

### Asynchronous code

> Use asynchronous versions of the Node.js API functions whenever possible.

For instance, avoid `readFileSync` but instead use `readFile`. Even if your code
is less readable as a result and that particular piece of code does not need to
be asynchronous (because you cannot proceed until you’ve read that file anyway),
it will not block other server threads. However if your program does not use
concurrency, synchronous versions are sometimes preferable as they are more
readable and less heavy on the operating system.

> Avoid inline callbacks

```js
// Prefer:
const pwdReadCallback = function (err, data) {
  // ...
}
fs.readFile('/etc/passwd', pwdReadCallback)

// over:
fs.readFile('/etc/passwd', (err, data) => {
  // ...
}

// Another example:

const done = function (resolve, reject) {
  return () => {
    try {
      // Do something that might fail
      resolve('Success - all went well')
    } catch (err) {
      reject(err)
    }
  }
}

const waitAndSee = function (resolve, reject) {
  setTimeout(done(resolve, reject), 2500)
}

const log = status => message => console.log(status + ': ' + message)

new Promise(waitAndSee)
  .then(log('Success'))
  .catch(log('Failure'))
```

This will avoid "callback hell" and encourage organising callback functions
linearly, in an event-driven fashion. It also makes it easier to write unit
tests for those functions.

```js
const pwdReadCallback = function (err, data) {
  // ...
}
const userLoggedInCallback = function (authToken) {
  // ...
}
const dbRequestResultCallback = function (req, res) {
  // ...
}
```

Separating out a callback may pose a problem when it needs its original scope. This can be handled by currying the callback:

```js
fs.readFile(filename, callback(filename))

const callback = filename => (err, data) => {
  if (err) {
    console.log(`Failed reading ${filename}.`)
    throw err
  }
  // ...
}
```

#### Use of `async`/`await`

You should use async functions, and the await keyword, to organise your asynchronous code. This will make your code easier to read and write.

```js
// Without async/await:
const getUserFromCreds = function (username, password) {
  return getUserIdFromAuth(username, password)
    .then(userId => {
      return getUserFromApi(userId)
    })
    .then(user => {
      return {
        id: user.id,
        name: user.name,
        age: user.ageInYears
      }
    })
}

// With async/await:
const getUserFromCreds = async function (username, password) {
  const userId = await getUserIdFromAuth(username, password)
  const user = await getUserFromApi(userId)

  return {
    id: user.id,
    name: user.name,
    age: user.ageInYears
  }
}
```

The `await` keyword will pause execution until its promise fulfills. This means a sequence of awaited promises can only execute in the order they’re declared, each being forced to wait for the previous one.

The promises API provides several [methods for managing sequences of promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise#static_methods), which can be used to solve this problem, for example:

```js
const getUserFromCreds = async function (username, password) {
  // Use await to make this promise blocking:
  const userId = await getUserIdFromAuth(username, password)

  const [avatarImgUrl, user] = await Promise.all([getAvatarForUser(userId), getUserFromApi(userId)])

  return {
    id: userId,
    name: user.name,
    age: user.ageInYears,
    avatar: avatarImgUrl
  }
}
```

If none of those offer the control needed, you can also [instantiate promises separately from when you await them](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Asynchronous/Async_await#handling_asyncawait_slowdown), for example:

```js
const getUserFromCreds = async function (username, password) {
  // Use await to make this promise blocking:
  const userId = await getUserIdFromAuth(username, password)

  // Start other promises running before awaiting:
  const avatarPromise = getAvatarForUser(userId)
  const userPromise = getUserFromApi(userId)

  const avatarImgUrl = await avatarPromise
  const user = await userPromise

  return {
    id: userId,
    name: user.name,
    age: user.ageInYears,
    avatar: avatarImgUrl
  }
}
```

### Functional programming

> Use JavaScript’s functional programming features

JavaScript has the advantage that it offers functional programming concepts
natively, like functions as first-class objects, higher-order functions (like
`map`, `reduce` or `apply`) or pattern matching.

Following functional programming principles, such as immutable data structures
and pure functions, produces code that is easier to test, less prone to runtime
errors and is often more performant. Write functions as expressions that return
values of a single type.

Side effects in a function can have bad consequences, especially within `map` or
`reduce`. `this` is better avoided, as it can refer to different objects
depending on the context in which a function is executed and lead to unexpected
side-effects.

Remain aware that JavaScript is not just a functional language and you will
most probably have to mix functional and object-oriented concepts, which can
be tricky to get right.

More guidance:

- [An Introduction to Functional JavaScript](https://www.sitepoint.com/introduction-functional-javascript/)
- [JavaScript Allongé](https://leanpub.com/javascriptallongesix/read)

## Errors

> Make sure you handle all errors

Envisage all error scenarios, in particular in asynchronous callback functions
or Promises, and have a fallback for any situation. Consider programmer errors
(bugs) as well as operational errors (arising from external circumstances,
like a missing file). Bugs that are caught by exceptions should be logged and
the execution stopped, and the supervisor will restart the process. Use the
built-in `Error` object instead of custom types. It makes logging easier.

Your application should not trust any input, for example from a file or an
API. So the application should handle all operational errors and recover from
them.

## Security

> Maintain [NodeJS Security best practices].

Use the LTS version.

If using the core HTTP Server, make sure all routes have error handling. Without error handling a DoS attack is possible. Using a framework should mitigate this as it should set default values for timeouts on idle requests.

Use `npm ci` over `npm install` as this enforces the use of the lockfile so that inconsistencies between the lockfile and package.json are represented as errors and not ignored.

Don’t [Monkey Patch] existing properties in runtime to change expected behaviour. This can cause side effects in core NodeJS modules and the libraries you are using. For example:

```js
// Dont do this.
Array.prototype.push = function (item) {
  // overriding the global Array[].push
};
```

An extensive list of security mitigations can be found on the [NodeJS Security best practices]


## Node.js’s HTTP server

> Offload Node’s server as much as possible

Do not expose Node’s HTTP server to the public. Use a reverse proxy to serve
static assets, and cache content as much as possible. Implement adequate
supervising: [pm2](https://pm2.keymetrics.io/) is recommended for Node.js-specific
servers.

## Transpiling

> Stick to JavaScript

Avoid anything that compiles to JavaScript (except for static type checking, see
below). Examples to avoid include CoffeeScript, PureScript and [many others](https://github.com/jashkenas/coffeescript/wiki/List-of-languages-that-compile-to-JS).

If you would like to use static typing consider using JavaScript extensions like
[TypeScript](https://www.typescriptlang.org/), or [Flow](https://flow.org/). This
has the advantage of making it easier to prevent runtime errors, by adding type
information to variables or parameters and transpiling the source to JavaScript,
reporting errors when wrong types are used.

However be aware that there are disadvantages too: augmented source code will no
longer be executable uncompiled. You may also need some extra type definitions if you
want to use external libraries.

Generally, anything that departs from the standard JavaScript syntax in a way
that a Node developer would have trouble reading your code is advised against.

## Frameworks

It is important to remember that we use the
[govuk-frontend](https://github.com/alphagov/govuk-frontend) to build pages on websites
at GDS. This restricts the choice of webservers to ones that easily support rendering
content using [Nunjucks](https://mozilla.github.io/nunjucks/). This rules out many
currently popular webservers that use React or other templating approaches.

> Use Koa or Express for web applications, avoid lesser-known frameworks

Express is widely used at GDS. It is the oldest Node.js webserver framework and there is a
wide range of examples and helper libraries available on the wider internet. However is has
less support for more modern JavaScript features, most notable support for `await/async`.
These issues require extra workarounds.

Koa can be used as an alternative if it better fits your requirements.

[Koa vs Express](https://github.com/koajs/koa/blob/master/docs/koa-vs-express.md) is a good comparison guide to help
 inform that decision.


If you find yourself looking for an <abbr
title="model-view-controller">MVC</abbr> framework or if you need an <abbr
title="object relationship manager">ORM</abbr> to manage records in a database,
[you probably should not be using Node.js in the first
place](/standards/programming-languages.html#frontend-development).

## Libraries

> Avoid libraries that produce esoteric code, or that have a steep learning curve

Using advanced libraries can make code very hard to read for developers not familiar
with them, as useful as they may be. For instance, [Ramda](https://ramdajs.com/)
lets you write:

```js
R.cond([
 [R.is(Number), R.identity],
 [R.is(String), parseInt],
 [R.T, R.always(NaN)]
])
```

This is compact and useful, but not easily understood up by a developer not
familiar with Ramda.

Generally, readable code is better than compact or advanced code. Optimisation
can lead to very arcane code, so should only be used when necessary.

```js
// Prefer:
for (let i = 0; i < 10; i += 1) {
  for (let j = 0; j < 10; j += 1) {
    console.log(i, j)
  }
}

// Over:
for (let i=0,j=0;i<10 && j<10;j++,i=(j==10)?i+1:i,j=(j==10)?j=0:j,console.log(i,j)){}
```

## Node Package Manager (<abbr title="Node package manager">NPM</abbr>)

> Do not reinvent the wheel, but do not over-use the amount of external code you
  import.

Using other people’s code is a risk. NPM is no exception and is arguably worse
than other package managers as the small granularity of packages leads to a very
large number of dependencies. Your application may easily end up relying on
software written by hundreds of different people, most of whom you do not know.

However, given that it’s impossible not to depend on foreign code, you should do
your best to reduce the risks involved:

- avoid relying on packages for functionality you can easily implement yourself,
  especially if a package has a lot of functionality you do not need.
- empirically check the trustworthiness of a package you wish to use: check
  its popularity, author reputation and so on.
- Use tools like [GitHub security alerts](https://help.github.com/en/github/managing-security-vulnerabilities/about-security-alerts-for-vulnerable-dependencies) or [Snyk](https://snyk.io/) to check packages for vulnerabilities

> Use `npm init`, `npm start`, `npm ci`, NPM scripts and so on

Making full use of NPM’s features will simplify your continuous integration and deployment.

> Lock down dependencies

Avoid incompatible upgrades that may break your application. NPM 5 does it by
default, but be careful when upgrading or adding a new package.

> Regularly check for unused dependencies, and make sure you do not have dev dependencies in production

Do not slow down your deployments with unused code.

> If you build modules you think could be useful for others, publish them on npm

Because [Open Source is a Good
Thing](https://technology.blog.gov.uk/category/open-source/).

> Published modules should be tested and supported on the last two current LTS
versions of Node.js.

### See also:

- [Controlling the Node.js security risk of npm dependencies](https://blog.risingstack.com/controlling-node-js-security-risk-npm-dependencies/)
- [I’m harvesting credit card numbers and passwords from your site. Here’s how.](https://hackernoon.com/im-harvesting-credit-card-numbers-and-passwords-from-your-site-here-s-how-9a8cb347c5b5)
- [you might not need gulp or grunt](https://www.freecodecamp.org/news/why-i-left-gulp-and-grunt-for-npm-scripts-3d6853dd22b8/).

## Further reading or information

In the GDS context, the guidelines provided in the links below are advisory
only. The guidance provided here takes precedence in case of conflicts.

* **[NodeJS Security best practices]** - A guide to security best practices by the Node working group.
* **[Node best practices]** — A comprehensive guide to Node.js best practices
* **[node.cool]** — A curated list of Node.js packages and resources by Sindre Sorhus
* **[JS documentation]** — MDN’s definitive JS docs
* **[#Nodejs]** – community’s Slack channel

[StandardJS]: https://standardjs.com
[ESLint]: https://eslint.org
[Node.js LTS Schedule]: https://github.com/nodejs/Release#release-schedule
[#Nodejs]: https://gds.slack.com/messages/nodejs
[node.cool]: https://github.com/sindresorhus/awesome-nodejs
[Node.js ES2015 support]: https://node.green/
[JS documentation]: https://developer.mozilla.org/en-US/docs/Web/JavaScript
[Node best practices]: https://github.com/goldbergyoni/nodebestpractices
[NodeJS Security best practices]: https://nodejs.org/en/docs/guides/security/
[Monkey Patch]: https://en.wikipedia.org/wiki/Monkey_patch

