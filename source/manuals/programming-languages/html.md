---
title: HTML coding style
eleventyNavigation:
  parent: Style guides
last_reviewed_on: 2023-05-02
review_in: 12 months
owner_slack: '#frontend'
permalink: manuals/programming-languages/html.html

---

## Browser support

The GOV.UK Service Manual lists the [minimum browsers that GOV.UK services are required
to support](https://www.gov.uk/service-manual/technology/designing-for-different-browsers-and-devices#browsers-to-test-in).
Tools such as GOV.UK Frontend, that are used to help build services, may have
[stricter standards of browser support](https://github.com/alphagov/govuk-frontend#browser-support).
Therefore, you will need to test your code in different browsers depending on
which part of GDS you are working in.

Your page should work with only HTML, before adding any CSS or JavaScript. Read
[building a resilient frontend using progressive enhancement](https://www.gov.uk/service-manual/technology/using-progressive-enhancement).

## Document structure

Use HTML5 to structure your page semantically. Use [ARIA roles](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles) to help
older assistive technologies map the sections correctly.

Léonie Watson explains [how to use ARIA landmark roles to deliver the
best experience for screen reader users](https://tink.uk/screen-readers-aria-html5-too-much-information/).

This document does not prescribe whether to use single or double quotes in attributes,
whether to omit values from attributes that do not need them or whether to add
trailing slashes to void elements. However, the approach you adopt should be
consistent throughout your code.

### Header

`<header role="banner">` should be used to contain your home link, branding, search,
and any global navigation you may have.

### Main content

`<main role="main">` should be used to identify the main content of your page.

A "Skip to main content" link should be added to help screen reader and keyboard
users skip past your general site navigation and get straight to the content.
You can use the [skip link component from the GOV.UK Design System](https://design-system.service.gov.uk/components/skip-link/)
for this.

### Navigational elements

Use `<nav role="navigation">` to wrap groups of links that are not already in
another context (for example, `<footer>`). Common examples of navigation sections are
menus, tables of contents, and indexes.

If you use more than one `<nav>` block in your page it is advisable to give
each one an [accessible name](https://www.tpgi.com/what-is-an-accessible-name/) using
[aria-labelledby](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-labelledby)
or
[aria-label](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-label),
to make clear the type of navigation contained by each.

The GOV.UK blog has [more information regarding the use of the `<nav>` tag](https://insidegovuk.blog.gov.uk/2013/07/03/rethinking-navigation/).

### Aside

`<aside role="complementary">` should be used for content related to the primary content
of the webpage, but which does not constitute the primary content of the page.

Examples include author information, related links and related content.

### Footer

`<footer role="contentinfo">` should be used for the footer of the site.

### Region landmarks

Use region landmarks to surface important areas of a page where it's not
appropriate to use any of the other types of landmarks.

You can create region landmarks by using the `<section>` tag. The `<section>` must
have an [accessible name](https://www.tpgi.com/what-is-an-accessible-name/), which can be provided using the
[aria-labelledby](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-labelledby)
or
[aria-label](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-label)
attributes. [A `<section>` tag without an accessible name is semantically the same
as a `<div>` tag](https://w3c.github.io/html-aam/#el-section).

Region landmarks should only be used where users will likely want to be able to
navigate to the grouping easily and to have it listed in a summary of the page.

You can already use headings and the other landmarks to identify sections of
the page. Region landmarks should be used only when those are proven not to
work well enough and doing so saves users more effort than it adds.

## Individual element guidance

### Headings

Headings should be in order - for example `<h1>` then `<h2>`, but not `<h1>` then `<h3>`.

There should only be one `<h1>` element in a page.

### Text emphasis

Italics should be avoided according to the [GOV.UK content style guide](https://www.gov.uk/guidance/style-guide).

Bold can be used sparingly, but can make large blocks of text difficult to read.

Semantically, words voiced with emphasis can be marked up with `<em>`, whereas
words conveying a sense or urgency or warning should be marked up with
`<strong>`. In theory screen readers could adopt a different tone of voice for
this markup, though none of the major ones currently do.

Browsers will render `em` in italics and `strong` in bold by default, so you may
need to override `em` to not use italics.

As a rule, avoid using `<i>` or `<b>`, which are only useful in rare cases. It
is usually better to use the `font-style` and `font-weight` CSS properties.

### Images

Read the [Design System's Images section](https://design-system.service.gov.uk/styles/images/).

### Buttons vs links

Links should be used for navigating to another page. Buttons should be used for submitting forms
or interactions within the page (for example, expanding an element). Empty links (`<a href="#">`)
should be avoided.

Links should not open new tabs or windows by default, but if users choose to do so (through keyboard
shortcuts or right-click context menu) then we should respect their choice.

### Visually hidden elements

Sometimes it can be helpful to provide additional content for screen reader users
that might not be needed for sighted users. For example, the 'Skip to main content'
link covered earlier.

Do not use `display: none` on this text, as this will get ignored by screen readers.

Instead, use CSS which ensures the text gets 'conceptually' rendered, even if the result
is not visible on the screen. You can use the
[Sass mixins from govuk-frontend](https://github.com/alphagov/govuk-frontend/blob/master/src/govuk/utilities/_visually-hidden.scss)
or the classes `govuk-visually-hidden` and `govuk-visually-hidden-focusable`.

Visually hidden text is often a sign that something can be simplified or made visible to
benefit sighted users too, so should be used sparingly.
