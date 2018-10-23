---
title: Manage third party software dependencies
last_reviewed_on: 2018-04-11
review_in: 6 months
---

## Manage third party software dependencies

When you develop and operate a service, it’s important to keep any third party dependencies you use up to date. By doing this, you can avoid potential security vulnerabilities.

Any automated tools you use to manage third party dependencies should be compatible with [GDS supported programming languages][]. The tools you use should neither slow down your development process nor disclose potential security vulnerabilities to the public.

You can read more about [managing software dependencies in the Service Manual][], where you will find a list of common dependency management tools.

<<<<<<< HEAD:source/documentation/operate-services/tracking-dependencies.md
### Programming languages and their dependencies
=======
Our [programming language style guides][] also contain language-specific advice about managing dependencies (for example, [managing Python dependencies][]).
>>>>>>> master:source/standards/tracking-dependencies.html.md.erb

## Monitoring for vulnerabilities

<<<<<<< HEAD:source/documentation/operate-services/tracking-dependencies.md
#### Ruby
=======
### Ruby - GOV.UK Gem Security Checker
>>>>>>> master:source/standards/tracking-dependencies.html.md.erb

You should use the [GOV.UK Gem Security Checker][] alongside your regular code checks. This will help your team move any code vulnerabilities into the team’s work backlog. You can then:

* prioritise fixes relative to other project work
* address vulnerabilities in private before making the fix public

<<<<<<< HEAD:source/documentation/operate-services/tracking-dependencies.md
### Dependency management tools
=======
### Snyk
>>>>>>> master:source/standards/tracking-dependencies.html.md.erb

[Snyk][] is a dependency management tool which can [monitor code dependencies][] for security vulnerabilities. Using Snyk allows you to automatically check GitHub pull requests (PRs) for vulnerable dependencies and potentially create a pull request to fix them. It also supports the other languages that GDS uses, including Python, Java and JavaScript.

<<<<<<< HEAD:source/documentation/operate-services/tracking-dependencies.md
### Case study - Snyk
=======
> The GDS Way does not mandate the use of Snyk: please contribute any experience you have of other dependency management tools to this document.
>>>>>>> master:source/standards/tracking-dependencies.html.md.erb

Snyk is being used successfully in the Digital Marketplace and GOV.UK Pay programmes. The Digital Marketplace uses Snyk as a pre-merge check on all pull requests for its public repositories. The developers also review the weekly report for new vulnerabilities, applying fixes manually instead of using Snyk's automatic pull request feature. The reports can be configured to ignore vulnerabilities that have no fix.

[GDS supported programming languages]: /standards/programming-languages.html#content
[managing software dependencies in the Service Manual]: https://www.gov.uk/service-manual/technology/managing-software-dependencies
[programming language style guides]: /manuals/programming-languages.html
[managing Python dependencies]: /manuals/programming-languages/python/python.html#dependencies
[GOV.UK Gem Security Checker]: https://github.com/alphagov/govuk_security_audit
[Snyk]: https://snyk.io/
[monitor code dependencies]: https://snyk.io/features
