---
title: Use continuous delivery
eleventyNavigation:
  parent: Version control and deployments
last_reviewed_on: 2023-11-02
review_in: 12 months
permalink: standards/continuous-delivery.html
---

[Continuous delivery][] helps you implement changes like new features into production quickly and safely. 

## Benefits

Using continuous delivery has multiple benefits.

### Iterate code frequently

It’s cheaper and easier to deliver small changes to production, meaning you can get feedback from users quickly.

### Low-risk releases

Frequent small changes make it easier to diagnose problems, and the cost of fixing them is much lower than with large releases.

### Quality software builds

Automated test suites allow you to quickly identify regressions in your software. This means you can focus on exploratory, usability, performance and security testing.

### Maintainable code

Building and releasing software in small pieces helps you focus on writing small composable bits of code. This means your code is easier to maintain and update.

## Essential concepts

To achieve continuous delivery you need:

- frequent integration to the main branch
- automatic build promotion
- production monitoring

### Frequent integration to the main branch

We generally use [Pull Requests][] for our development processes.
Long-lived branches mean a longer wait time to see changes in production, and a greater risk of merge conflicts.
You should aim to have small Pull Requests, so that they are easier to review and can be merged more quickly.
You should aim for your feature branches to live for only a day or two before getting merged.
If a branch lasts longer than this, you could ask for help, or consider a different approach to the problem.

You can use approaches like [feature-flagging][] or [modular architectures][] to deploy partially complete features. This reduces the size of changes going to production and encourages your team to build modular, configurable systems. 

### Automatic build promotion

You can quickly distinguish between good and bad builds with automatic build promotion. By deploying builds that have to pass multiple test jobs downstream of the initial build process you can get quicker feedback if the build fails.

### Use production monitoring and alerting

You can understand the effect of your changes on production using [production monitoring and alerting][]. Monitoring essential parts of your system allows you to see if changes have any unintended impacts and to respond quickly in case of problems.

## Further reading

Find out more about continuous delivery from:

- [Architecting for Continuous Delivery][] - Jez Humble at Agile India 2016 (video)
- [2023 State of DevOps Report][] - see where you are and how to get to the next stage
- [Accelerate: The Science of Lean Software and Devops: Building and Scaling High Performing Technology Organizations][Accelerate] - by Nicole Forsgren Jez Humble Gene Kim
- [Trunk Based Development][] - a source control branching method

[Continuous delivery]: https://www.continuousdelivery.com
[feature-flagging]: https://martinfowler.com/articles/feature-toggles.html
[modular architectures]: https://continuousdelivery.com/implementing/architecture/
[production monitoring and alerting]: /standards/monitoring.html
[Pull Requests]: /standards/pull-requests.html
[Architecting for Continuous Delivery]: https://www.youtube.com/watch?v=Lx9ssegE6FA
[Accelerate]: https://wordery.com/accelerate-nicole-forsgren-phd-9781942788331?cTrk=OTc2NDYwNzZ8NWI2ZDg5NGJkYzAyZjoxOjE6NWI2ZDg5NDQwM2ZhODguNDU0MTgxMTU6ODJlODM3ODY%3D
[Trunk Based Development]: https://trunkbaseddevelopment.com/
[2023 State of DevOps Report]: https://cloud.google.com/blog/products/devops-sre/announcing-the-2023-state-of-devops-report
