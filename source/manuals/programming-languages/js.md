---
title: JavaScript coding style
eleventyNavigation:
  parent: Style guides
last_reviewed_on: 2023-01-27
review_in: 12 months
owner_slack: '#frontend'
permalink: manuals/programming-languages/js.html

---

## Linting

We follow [standardjs](https://standardjs.com/), an opinionated JavaScript linter. In cases where [standard conflicts with a service's browser support](#when-to-use-standardx) we use [standardx][].

All JavaScript files follow its conventions, and it typically runs on CI to ensure that new pull requests are in line with them.

[standardx]: https://github.com/standard/standardx

### Running standard manually

To check the whole codebase, run:

```bash
npx standard
```
### Running standard in your editor

Easier than running standard manually is to install it as a plugin in your editor. This way, it will run automatically while you work, catching errors as they happen on a per-file basis.

There are [official guides for most of the popular editors](https://standardjs.com/index.html#are-there-text-editor-plugins).

### When to use standardx

You should use [standardx][] when the standard's rule set conflicts with the browsers your project supports. For example, the [no-var](https://eslint.org/docs/rules/no-var) rule in standard - which prefers `let` or `const` over `var` - prevents JavaScript usage in versions of Internet Explorer < 11. Adopting this rule would mean explicitly breaking JavaScript for those browsers.

Once installed you can then override standard rules with an [`.eslintrc`][eslintrc] file or an `eslintConfig` entry in package.json ([example][govuk-warnings]).

You should be cautious to only make use of standardx to resolve compatibility issues and not as a means to adjust rules to individual preferences.

Note: you may find that using standardx complicates integration with text editors.

[eslintrc]: https://eslint.org/docs/user-guide/configuring
[govuk-warnings]: https://github.com/alphagov/govuk_publishing_components/commit/ea7f0becc76f73780b6cb33701bea9e58f15f91a

### Why standard?

Linting rules can be a contentious subject, and a lot of them are down to personal preference. The core idea of standard is to be opinionated and limit the amount of initial bikeshedding discussions around which linting rules to pick, because in the end, it's not as important which rules you pick as it is to just be consistent about it. This is why we chose standard: because we want to be consistent about how we write code, but do not want to spend unnecessary time picking different rules (which all have valid points).

The standard docs have a [complete list of rules and some reasoning behind them](https://standardjs.com/rules.html).

Standard is also [widely used (warning: large file)](https://github.com/feross/standard-packages/blob/master/all.json) (which means community familiarity) and has a [good ecosystem of plugins](https://standardjs.com/awesome.html).

If we decide to move away from it, standard is effectively just a preconfigured bundle of eslint, so it can easily be replaced by switching to a generic `.eslintrc` setup.

## Whitespace

Use soft tabs with a two space indent.

**Why:** This follows the conventions used within our other projects.

## Naming conventions

* Avoid single letter names. Be descriptive with your naming.

  ```javascript
  // Bad
  var n = 'thing'
  function q () { ... }

  // Good
  var name = 'thing'
  function query () { ... }
  ```

  **Why:** Descriptive names help future developers pick up parts of the code
  faster without having to read it all.

* Use camelCase when naming objects, functions, and instances.

  ```javascript
  // Bad
  var this_is_my_object = {}
  var THISIsMyVariable = 'thing'
  function ThisIsMyFunction() { ... }

  // Good
  var thisIsMyObject = {}
  var thisIsMyVariable = 'thing'
  function thisIsMyFunction() { ... }
  ```

* Use PascalCase when naming constructors or classes.

  ```javascript
  // Bad
  function user (options) {
    this.name = options.name
  }
  var Bob = new user({
    name: 'Bob Parr'
  })

  // Good
  function User(options) {
    this.name = options.name
  }
  var bob = new User({
    name: 'Bob Parr'
  })
  ```

**Why:** This lets future developers know how to interact with objects and sets the appropriate affordances. It also follows the conventions of the standard library.

## CoffeeScript

Do not use CoffeeScript.

**Why:** It's an extra abstraction and introduces another language for developers to learn. Using JavaScript gives us guaranteed performance characteristics and more well known support paths.

## HTML class hooks

When attaching JavaScript to the DOM use a `.js-` prefix for the HTML classes.

Eg `js-hidden` or `js-tab`.

**Why:** This makes it completely transparent what the class is used for within the HTML. It also makes it much easier to search in a project to remove old behaviour.

## Styling elements

Do not apply styles directly inside JavaScript. You should only ever apply CSS classes and style from there.

**Why:** This reduces the risk of clobbering user stylesheets and mixing concerns across different code bases. Also see [HTML class hooks](#html-class-hooks).

## Strict mode

You should add the `'use strict'` statement to the top of your module functions.

**Why:** This enables [strict
mode](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions_and_function_scope/Strict_mode).

Strict mode converts many mistakes, such as undefined variables, into errors which makes it easier to determine why things are not working. It also forces scope so you do not accidentally export globals.

## Modules

Avoid assigning modules to the `window` global scope.

Bundlers such as [Rollup](https://rollupjs.org/) avoid the need to do this manually.

To do this manually, wrap your code in a closure, then attach the module to the global scope with a namespace:

```javascript
;(function (global) {
  'use strict'

  var GOVUK = global.GOVUK || {}

  ...

  GOVUK.myModule = ...

  ...

  global.GOVUK = GOVUK
})(window); // eslint-disable-line semi
```

**Why:** attaching to the `GOVUK` object keeps us from polluting the global namespace. Checking for or creating the `GOVUK` object means the module can be reused on any project (internal or external) without having to modify it. You get the benefits of [strict mode](#strict-mode) which include stopping your module from leaking variables into the global scope. The [IIFE](https://en.wikipedia.org/wiki/Immediately-invoked_function_expression) should be wrapped with semicolons to ensure no issues with concatenation can happen.

## Module structure

Module logic should be broken down into small testable functions. The functions should be exposed as methods on the module rather than hidden inside a closure.

```javascript
// Bad
function myModule ($element) {
  function showThing () { ... }
  function hideThing () { ... }
  function submitThing () { ... }
  function getArgumentsForThing () { ... }

  $element.click(submitThing)
}

// Good
function MyModule ($element) {
  $element.click($.bind(this.submitThing, this))
}
MyModule.prototype.showThing = function () { ... }
MyModule.prototype.hideThing = function () { ... }
MyModule.prototype.submitThing = function () { ... }
MyModule.prototype.getArgumentsForThing = function () { ... }

// Good
GOVUK.myModule = {
  showThing: function () { ... },
  hideThing: function () { ... },
  submitThing: function () { ... },
  getArgumentsForThing: function () { ... },
  init: function ($element) {
    $element.click(GOVUK.myModule.submitThing)
  }
}
```

**Why:** Having small well named functions lets developers who are unfamiliar with the code understand what is going on faster. Having logic in small functions makes it easier to unit test each of those functions to prove they performs as expected. Having those functions exposed as methods on the module makes it possible to test those functions in isolation.

## jQuery

Avoid jQuery in new projects.

In older projects put together a plan to migrate away from jQuery.

**Why:** jQuery had been used to provide browser support for older browsers. However, browser support for ES5 JavaScript is now widespread enough that a library like jQuery is unnecessary. The older versions of jQuery that we use have security vulnerabilities and are no longer maintained by the jQuery team.

## Supporting older browsers

Use native web APIs where possible.

Use [feature detection](https://developer.mozilla.org/en-US/docs/Learn/Tools_and_testing/Cross_browser_testing/Feature_detection) before [polyfilling](https://developer.mozilla.org/en-US/docs/Glossary/Polyfill), to support older browsers.

## Method arguments

Favour named arguments in a object over sequential arguments.

```javascript
// Bad
function addAutoSubmitToInput (input, action, timeout, debug) { ... }

// Good
function addAutoSubmitToInput (input, options) {
  var action = options.action,
      timeout = options.timeout,
      debug = options.debug
  ...
}
```

**Why:** by using named options you do not necessarily have to read the internals of the method being called to work out what the arguments mean.

Given a call to `addAutoSubmitToInput($input, './search', 20, false)` you would have to go to that method to find out what `20` or `false` mean.

A call to `addAutoSubmitToInput($input, { action: './search', timeout: 20, debug: false })` gives you context as to what the arguments mean. It also makes it easier to refactor arguments without having to change all method calls.

[Connascence of naming is a weaker form of connascence than connascence of position](https://en.wikipedia.org/wiki/Connascence_%28computer_programming%29#Types_of_connascence).
