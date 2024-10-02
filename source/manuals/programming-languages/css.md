---
title: CSS coding style
eleventyNavigation:
  parent: Style guides
last_reviewed_on: 2023-04-03
review_in: 12 months
owner_slack: '#frontend'
permalink: manuals/programming-languages/css.html
---

## Contents

- [Contents](#contents)
- [Linting](#linting)
- [Whitespace](#whitespace)
- [Spacing](#spacing)
  - [Use with deprecated libraries](#use-with-deprecated-libraries)
- [Use `rem` units strategically](#use-rem-units-strategically)
- [Vendor prefixing](#vendor-prefixing)
- [Sass nesting](#sass-nesting)

## Linting

Your project should conform to GDS CSS/Sass linting rules, these are published as a [stylelint](https://stylelint.io) configuration: [stylint-config-gds](https://github.com/alphagov/stylelint-config-gds).

## Whitespace

Use soft tabs with a 2 space indent. This follows the conventions we use in our other projects.

## Spacing

You should use the [GOV.UK Design System spacing scale](https://design-system.service.gov.uk/styles/spacing/).

### Use with deprecated libraries

If your project is not using the GOV.UK Design System, you should use pixel values in multiples of `5px`.

## Use `rem` units strategically

As a general rule, per [Josh W. Comeau's _The Surprising Truth About Pixels and Accessibility_] (https://www.joshwcomeau.com/css/surprising-truth-about-pixels-and-accessibility/#strategic-unit-deployment-6):

> When picking between pixels and rems, here's the question you should be asking yourself: Should this value scale up as the user increases their browser's default font size?

Use `rem` units for `font-size` wherever possible.

You should generally avoid using `rem` for padding or border-width if these are likely to cause layout or readability issues when the font-size increases.

## Vendor prefixing

When using CSS features which require vendor prefixes use [autoprefixer](https://github.com/postcss/autoprefixer).

You should [configure autoprefixer](https://github.com/postcss/autoprefixer#browsers) to target [our supported browsers](https://www.gov.uk/service-manual/technology/designing-for-different-browsers-and-devices#browsers-to-test-in).

## Sass nesting

Sass nesting should be avoided where possible.

Over use of nesting can make searching for selectors difficult and can hide complicated CSS that should be simplified.

Exceptions to this include pseudo selectors and JavaScript enabled classes.

```scss
.accordion {
  // styles when the accordion is not enhanced here
}
.js-enabled {
  .accordion {
    // styles when the accordion is enhanced here

    &:focus {
      // ...
    }
  }
}
```
