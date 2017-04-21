---
title: Programming languages
layout: recommendation
expires: 2017-10-01
---

We want to use a range of programming languages at GDS because we think
using the right tool for the job will give us the best chance of building
services that best meet users’ needs. This document does not apply to
choosing 'off the shelf' software (open source or not).

We want to focus on using a small number of programming languages for
core software development tasks.

This should make it easier for developers to:

- move around the organisation
- develop shared components
- improve their personal development
- master how they operate applications

## Core languages

Our core languages are __Java, Python and Ruby__.

We've chosen these 3 languages because they are successfully used by
teams at the moment, and we are confident in how to host and operate
applications written in them. We'd advise you to carry out new
development in one of them.

## Languages in use in specific contexts

### JavaScript

This recommendation only applies to server-side JavaScript.
The service manual has information on
[using client-side JavaScript][manual_js].

[manual_js]: https://www.gov.uk/service-manual/technology/using-progressive-enhancement

The only way we're comfortable writing server-side JavaScript at the
moment is with [Node.js][nodejs].

[nodejs]: https://nodejs.org/

Node.js is used by a few projects at GDS; GOV.UK Frontend, GOV.UK Pay and the Performance Platform.

In the past we've had problems operating and maintaining products written in
Node.js. We suspect that this is because:

- It's younger and less mature than Java, Python and Ruby
- We have fewer developers with Node.js skills than other tools we use

Because both of these points should gradually improve over time, we think
that Node.js is suitable for creating thin, client-facing applications
that don't persist data.

### Go

The GOV.UK router is built using Go, and it's the core language for Cloud
Foundry which runs our Platform as a Service.

Go is an appropriate language for some systems programming, like proxying,
routing and transforming HTTP requests. However, since we don't maintain much
Go and thus are likely to have few people with the skills to do so, any such
code poses a significant risk. Components should only be written in Go if
there is no alternative maintained open source tool which could be used, and
after a team has developed a plan to ensure that it will have the skills to
maintain the component in future.

## Languages we won't use for new projects

We used __Scala__ in the early days of GDS. GOV.UK Licensing is the only remaining
application written in Scala. Do not use Scala for new projects.

## Other languages

There will be sensible reasons to pick another language. For example when you're:

- extending an existing codebase or ecosystem
- scripting in a particular environment
- experimenting during an alpha (with an expectation that it's replaced by something we have more confidence in for beta)
- working in a very specific or unusual problem domain, like heavy use of WebSockets

The set of languages we're comfortable supporting will change over time.

If you want to use a new language, talk to your technical architect and create
a prototype. If it goes well make a pull request to change this document.

If you've had problems using one of the languages we support, make a pull request to
document the issues you've had.
