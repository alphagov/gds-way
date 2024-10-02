---
title: Tagging AWS resources
eleventyNavigation:
  parent: Hosting and infrastructure
last_reviewed_on: 2023-10-30
review_in: 12 months
permalink: manuals/aws-tagging.html
---

We use [AWS for hosting](../standards/hosting.html).
Most AWS resources support tagging.

This manual documents our efforts with tagging.
In time, it may be upgraded to a standard.

## Why tag?

The main reasons for tagging are:

 - to be able to understand costs (by assisting queries in Cost Explorer)
 - to understand the provenance of resources (by tagging with metadata about source code)
 - security and assurance

Currently, we care most about understanding costs.

It's not always clear to a developer what impact their work has on AWS costs.

If resources are consistently tagged as part of a particular directorate, programme, product, component, team, and environment, it becomes much easier to understand how much money is being spent in each particular context.

AWS Cost Explorer supports using cost allocation tags to filter and group resources.

Note that using AWS Organizations to tag accounts does not help here, because account-level tags are not supported for querying in Cost Explorer.

## Alerting and enforcement

Currently, we do not enforce tags.

In future, we may wish to consider mechanisms such as alerting on untagged resources, or automatically deleting untagged resources.


### Mandatory

 - `Product`: `GOV.UK One Login` / `GOV.UK` or `DSP`
 - `System`: the name of the software system, for example `Authentication` or `Identity proofing and verification core`. Avoid abbreviations.
 - `Environment`: should be one of `production`, `staging`, `integration`, or `development`.
 - `Owner`: an email address for an owner for the resource. For dev environments, this will be an individual email address; elsewhere it will be a group address.

### Optional

 - `Service`: used to describe the function of a particular resource (for example: `account management`, `session storage`, `front end`)
 - `Source`: the URL(s) for any source code repositories related to this resource, separated by spaces
 - `Exposure` : should specify the level of exposure the resource has to determine its attack surface area. (for example `internal` or `external`)
 - `Data Classification` : should specify the highest data classification level the resource handles. This will help internal security teams to know what level of controls to apply and help focus on the resources with greatest level of risk.
 - `Cost Centre` : helps the organisation's accounting or financial management system to track and allocate expenses or costs to specific departments, teams, projects, or functions

## References

This is based on:

 - [AWS documentation and best practices on tagging](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
 - [GDS's former tagging strategy](https://docs.google.com/presentation/d/1LHLKPclfrn5KVFrFd2WqyPOYpS6wXklE4Lexb2rJNW0/edit#slide=id.g10d43e3636_2_51)
 - [MoJ digital tagging strategy](https://technical-guidance.service.justice.gov.uk/documentation/standards/documenting-infrastructure-owners.html)
 - [the duckbill group's guide to tagging best practices](https://www.duckbillgroup.com/blog/aws-cost-allocation-guide-tagging-best-practices/)
