---
title: Programming languages
layout: recommendation
expires: 2017-10-01
---

All programming languages have their own strengths and weaknesses.
We want to use a range of programming languages in
order to build services and supporting tools to meet users' needs.
This document does not apply to choosing 'off the shelf' software
(open source or not).

In order to make it easier for developers to move around the organisation,
to get more value out of developing shared components, to better hire and
develop people, and to be great at operating applications, we want to focus
on a small number of choices of programming languages for core
software development tasks.

## Java, Python and Ruby

These are successfully being used by many teams at the moment and
we're confident in how to host and operate applications written in them.
New development should normally be carried out in one of them.

## JavaScript

This recommendation only applies to server-side JavaScript.
The service manual has information on
[using client-side JavaScript][manual_js].

[manual_js]: https://www.gov.uk/service-manual/technology/using-progressive-enhancement

The only way we're comfortable writing server-side JavaScript at the
moment is with [Node.js][nodejs].

[nodejs]: https://nodejs.org/

Node.js is used in a few projects at GDS; GOV.UK Frontend, GOV.UK Pay and Performance Platform.

In the past we've had problems operating and maintaining products written in
Node.js. We suspect that this is because:

- It's younger and less mature than other tools we use
- We have fewer developers with Node.js skills than other tools we use

Because both of these points should gradually improve over time, we think
that Node.js is suitable for creating thin, client-facing applications
that don't persist data.

## Go

The GOV.UK router is built using Go, and it's the core language for Cloud
Foundry which runs our Platform as a Service.

We suspect that Go may be suitable for some systems programming, like proxying,
routing and transforming HTTP requests.

## Scala

We used Scala in the early days of GDS. GOV.UK Licensing is the only remaining
application written in Scala. Do not use Scala for new projects.

## Other languages

There will be sensible reasons to pick another language. For example when we're:

- extending an existing codebase or ecosystem
- scripting in a particular environment
- experimenting during an alpha (with an expectation that it's replaced by something we have more confidence in for beta)
- working in a very specific or unusual problem domain, like heavy use of WebSockets

The set of languages we're comfortable supporting will change over time.

If you want to use a new language, talk to your technical architect and create
a prototype. If it goes well make a pull request to change this document.

If you've had problems using one of the languages we support, make a pull request to
document the issues you've had.
