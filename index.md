This site documents some of the technical decisions that the
[Government Digital Service](https://www.gov.uk/government/organisations/government-digital-service)
has made for the products we operate.

It complements the [Service Manual](https://www.gov.uk/service-manual) which
covers service design more broadly.

If you think that you can contribute a change to this repository which reflects
current practice at GDS, make a pull request to this repo and we'll discuss it
at the Tech Ops Forum meeting and in the
[#tech-ops-forum Slack channel](https://govuk.slack.com/messages/tech-ops-forum/).

Products at GDS must follow the
[discovery, alpha, beta and live phases set out in the Service Manual](https://www.gov.uk/service-manual/agile-delivery).
Products at discovery and alpha can optionally follow the recommendations
in this repository. Projects at beta and live should follow these recommendations.

## Topics

### Building software

- [Choosing programming languages](programming-languages.html)
- [Storing source code](source-code.html)

### Operating services

- [Storing and querying logs](logging.html)
- [Monitoring your service](monitoring.html)
- [Responding to problems](alerting.html)
- [Sending emails](sending-email.html)
- [Managing DNS](dns-hosting.html)

## Adding new guidance

Create a new Markdown file that follows this pattern and make a pull request:

```markdown
---
title: Thing you're writing a recommendation about
layout: recommendation
expires: yyyy-mm-dd (6 months from now)
---

Introduction of a couple of paragraphs to explain why the thing you're
writing a recommendation about is important.

## User needs

Why do we do this thing? Who is it helping?

## Principles

What broad approaches do we follow when we do this thing?

## Tools

What specific bits of software (commercial or open source) do
we use to help us do this thing?
```

The service manual has some useful information on
[learning about and writing user needs](https://www.gov.uk/service-manual/user-research/start-by-learning-user-needs).
