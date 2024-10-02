---
homepage: true
title: The GDS Way
---
{% from "./_includes/macros/table-of-contents/macro.njk" import xGovukTableOfContents %}

The GDS Way guides teams to build and operate brilliant, cost-effective digital services.

It documents the specific technology, tools and processes that Government Digital Service (GDS) teams use.

It's not intended as guidance for anyone working outside GDS (though some other Cabinet Office teams use it too) - you'll find that in the [Service Manual](https://www.gov.uk/service-manual).

## About The GDS Way

The GDS Way shares agreed ways of working so service teams benefit from:

* using similar tools
* central procurement
* costs savings as new teams will be cheaper to spin up

The GDS Way makes it easier for projects to get started while still giving teams flexibility to do something different if their project needs it.

The GDS Way includes consistent:

* terminology
* ways of working
* technology and tools
* measures

All decisions are made in alignment with [Service Manual](https://www.gov.uk/service-manual), which covers service design more broadly, and the [Technology Code of Practice](https://www.gov.uk/guidance/the-technology-code-of-practice).

Products at GDS in discovery or alpha development phases must follow [agile delivery principles](https://www.gov.uk/service-manual/agile-delivery) and also have the option to follow the standards in this repository.

Products in beta and live phases must follow both the instructions set out in the Service Manual and the standards in this repository.
They must be [secure by design](https://www.security.gov.uk/guidance/secure-by-design/).

## How to add new guidance

Contribute to this repository by making a pull request in [GitHub](https://github.com/alphagov/gds-way) for discussion at the GDS Way Forum.

You can also read the service manual to find out about
[learning about and writing user needs](https://www.gov.uk/service-manual/user-research/start-by-learning-user-needs).

Thank you for your contributions as we develop this repository.

### Submission template

When you create a new Markdown file follow this pattern and then make a pull request:

```text
---
title: Thing you're writing a standard about
eleventyNavigation:
  parent: [parent section title]
last_reviewed_on: yyyy-mm-dd
review_in: 6 months
---

Introduction of a couple of paragraphs to explain why the thing you're
writing a standard about is important.

## User needs

Why do we do this thing? Who is it helping?

## Principles

What broad approaches do we follow when we do this thing?

## Tools

What specific bits of software (commercial or open source) do
we use to help us do this thing?
```

## The GDS Way Forum

This site documents some of the decisions agreed at the GDS Way Forum about the products we operate.

The GDS Forum meets once a month. The Forum is lead developers and technical architects representing GDS programmes who are responsible for communicating and implementing the GDS Way.

The Forum reviews:

* all GDS Way open and closed PRs
* expired guidance and if it should be continued
* possible subject areas and ownership of new content

### Contact The GDS Way Forum

Contact the GDS Way Forum using the [#gds-way Slack channel](https://gds.slack.com/messages/gds-way/) or by email at <a href="mailto:the-gds-way@digital.cabinet-office.gov.uk?subject=feedback">the-gds-way@digital.cabinet-office.gov.uk</a>.

## Software development

{{ xGovukTableOfContents({
  items: collections.all | eleventyNavigation("Software development", navToHtmlOptions) | itemsFromNavigation(page.url, { pathPrefix: options.pathPrefix })
}) }}


## Version control and deployments

{{ xGovukTableOfContents({
  items: collections.all | eleventyNavigation("Version control and deployments", navToHtmlOptions) | itemsFromNavigation(page.url, { pathPrefix: options.pathPrefix })
}) }}

## Hosting and infrastructure

{{ xGovukTableOfContents({
  items: collections.all | eleventyNavigation("Hosting and infrastructure", navToHtmlOptions) | itemsFromNavigation(page.url, { pathPrefix: options.pathPrefix })
}) }}

## Logging, monitoring and alerting

{{ xGovukTableOfContents({
  items: collections.all | eleventyNavigation("Logging, monitoring and alerting", navToHtmlOptions) | itemsFromNavigation(page.url, { pathPrefix: options.pathPrefix })
}) }}

## Operating a service

{{ xGovukTableOfContents({
  items: collections.all | eleventyNavigation("Operating a service", navToHtmlOptions) | itemsFromNavigation(page.url, { pathPrefix: options.pathPrefix })
}) }}
