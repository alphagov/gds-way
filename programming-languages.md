---
title: Server-side programming languages
layout: recommendation
expires: 2017-09-01
---

All programming languages have their own strengths and weaknesses.
This means that we want to use a range of programming languages in
order to build services and supporting tools to meet users needs.
This document does not apply to choosing 'off the shelf' software
(open source or not).

In order to make it easier for developers to move around the organisation,
to get more value out of developing shared components, to better hire and
develop people, and to be great at operating applications, we want to focus
on a small number of choices of programming languages for core
'backend development' tasks.

These are (alphabetically): Java, Python, Ruby. These are successfully being
used by teams at the moment, and we are confident in how to host and operate
applications written in them. New development should normally be carried out
in one of them.

There will be sensible reasons to go outside this core group. For example:

- when we're extending an existing codebase/ecosystem
- when scripting in a particular environment
- when we're experimenting during an alpha (with an expectation that it's replaced by something from the core set for beta)

The set of languages in the core group will change over time. This is likely
to be through the adoption of a new language into the core group, and with
an existing language being put on hold for new work.

## Code styleguides

Developers read code much more often than they write it. These guidelines
are intended to improve the readability of code and make it consistent
across GDS projects.

A style guide is about consistency. Consistency with this style guide is
important. Consistency within a project is more important. Consistency within
one module or function is most important.

But most importantly: know when to be inconsistent -- sometimes the style guide
just doesn't apply. When in doubt, use your best judgement. Look at other
examples and decide what looks best. And don't hesitate to ask!

Some good reasons to ignore a particular guideline:

- When applying the guideline would make the code less readable, even for
  someone who is used to reading code that follows this style guide.
- To be consistent with surrounding code that also breaks it (maybe for
  historic reasons) -- although this is also an opportunity to clean up the
  existing code.
- Because the code in question predates the introduction of the guideline and
  there is no other reason to be modifying that code.
- When the code needs to remain compatible with older versions that
  don't support the feature recommended by the style guide.

We've got a consistent style for [Ruby](programming-languages/ruby.html) and will
add a guide for Python and Java.

## Languages in use not in the core group

### Go

A small amount of use in GOV.UK. Core language for CloudFoundry used by the
PaaS team.

### Node.js (JavaScript)

In use in GOV.UK Pay and Performance Platform. Not as mature as other
languages/frameworks in use, and lacking a critical mass of skills in
GDS, so further adoption discouraged. Note: does not apply to in-browser
JavaScript.

### Scala

Used in the early days of GDS. GOV.UK Licensing is the only remaining
application written in Scala. Not for use in new development.
