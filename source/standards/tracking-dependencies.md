---
title: How to manage third party software dependencies
eleventyNavigation:
  parent: Software development
last_reviewed_on: 2024-06-27
review_in: 6 months
permalink: standards/tracking-dependencies.html
---

When you develop and operate a service, it’s important to keep any third party dependencies you use up-to-date. By doing this, you can avoid potential security vulnerabilities.

Any automated tools you use to manage third party dependencies should be compatible with [GDS supported programming languages][]. The tools you use should neither slow down your development process nor disclose potential security vulnerabilities to the public.

You can read more about [managing software dependencies in the Service Manual][], where you will find a list of common dependency management tools.

Our [programming language style guides][] also contain language-specific advice about managing dependencies (for example, [managing Python dependencies][]).

## Update dependencies frequently

Update your dependencies frequently rather than in ‘big bang’ batches. This works well with [continuous delivery][] principles and makes sure the changes introduced are small and can be automatically tested.

There are tools which scan GitHub repositories and raise pull requests (PRs) when they find dependency updates. Teams at GDS are using:

* [Dependabot][] - used by GOV.UK, and GOV.UK Pay. The GOV.UK docs contain [guidance on using Dependabot][] and [how the PRs raised should be reviewed][]
    > Note: this is separate from the [security-only updates provided automatically by GitHub Dependabot].

    > Note: repos requiring at least one approving review for PRs cannot, and should not, use [Dependabot's auto-approve-and-merge facility].

    > Note: we have not enabled "Treat PR approval as a request to merge", as this would lead to a surprising behaviour at the point of approval.

    > Note: GOV.UK has implemented [RFC-167][] which allows automatic patching of all dependencies in certain cases.

* [PyUp][] - a Python dependency checker. Used by GOV.UK Notify, PyUp will monitor for updates and vulnerabilities

All the above tools are free to use on public repositories.

The COD Cyber Security team will review the repositories that do not have dependency management in use and will turn on Dependabot where required. Service teams are free to use a different tool such as [Snyk](https://snyk.io/), but will need to add a `no-dependabot` tag to their repository for monitoring purposes. You can [contact Cyber Security](https://gds.slack.com/archives/CCMPJKFDK) if you have any questions or need help.

## Monitor for vulnerabilities

You should monitor for potential vulnerabilities in every layer of your technology stack. This is not straightforward but tooling exists to help. The Service Manual provides [guidance on browser technology, tooling and mailing lists you can subscribe to][].

Most of the tooling that helps you stay on top of dependency updates will also highlight vulnerabilities. Additional tooling includes:

### [GitHub security alerts][]

When GitHub discovers or is informed about a vulnerability, it will email an alert to the repository owner and users with admin access. GitHub security alerts will be turned on for all Alphagov repositories. If services wish to opt out of security advisories on their repository, they can contact Cyber Security and then add the `no-security-advisories` tag to their repository.

### [Snyk][]

Snyk is capable of detecting vulnerabilities in a variety of languages including all the [GDS supported programming languages][]. You can configure Snyk to raise PRs, email regular reports and alert you when new vulnerabilities are detected.

If you have an old repository that is receiving security alerts but is not being worked on or maintained, you may wish to archive your repository instead.

### Splunk dashboards

The Cyber Security team has created a Splunk dashboard. This gives service teams visibility of vulnerabilities in their repositories. To allow for your repositories to be categorised correctly in the Splunk dashboard, please make sure you tag your repository with the service name. If you would like to access the dashboard, [contact Cyber Security](https://gds.slack.com/archives/CCMPJKFDK).

## Managing Docker dependencies

### Rebuild Docker base images

Like dependencies, Docker base images are also frequently updated. If you run containers as part of your service, you should regularly rebuild your images (and base images) to include the latest updates. Automate this process where possible.

### Specifying Docker image tags

The GDS Way Dockerfile guidance contains advice on how
to use [Docker image tags](/manuals/programming-languages/docker.html#using-tags-and-digests-in-from-instructions)
to specify the exact container image version to use.

### Use official Docker base images

Always use [official base images][]. Docker Hub regularly scans official images and you can view the results by logging into Docker Hub. If you do not regularly update your base image, you must make sure a manual process exists to monitor and prioritise fixes for detected vulnerabilities.

The Digital Marketplace team uses [Snyk container vulnerability management tooling][] to regularly scan base images.

## Minimise what you need to monitor

Minimise the things you need to monitor by minimising dependencies where possible. For example, if running containers, make sure you pick the smallest base images.

Also consider managed solutions where possible. For example:

* Use [GOV.UK PaaS buildpacks][] so you do not have to monitor for Operating System (OS), runtime or programming language vulnerabilities
* Consider managed container orchestration technology such as [AWS Fargate][] or similar so you do not have to monitor for vulnerabilities in your OS or control plane

[Dependabot's auto-approve-and-merge facility]: https://docs.github.com/en/code-security/supply-chain-security/keeping-your-dependencies-updated-automatically/automating-dependabot-with-github-actions
[security-only updates provided automatically by GitHub Dependabot]: https://docs.github.com/en/code-security/supply-chain-security/managing-vulnerabilities-in-your-projects-dependencies/about-alerts-for-vulnerable-dependencies
[GDS supported programming languages]: /standards/programming-languages.html#content
[managing software dependencies in the Service Manual]: https://www.gov.uk/service-manual/technology/managing-software-dependencies
[programming language style guides]: /manuals/programming-languages.html
[managing Python dependencies]: /manuals/programming-languages/python/python.html#dependencies
[Snyk]: https://snyk.io/
[monitor code dependencies]: https://snyk.io/features
[continuous delivery]: /standards/continuous-delivery.html
[Dependabot]: https://dependabot.com/
[guidance on using Dependabot]: https://docs.publishing.service.gov.uk/manual/manage-ruby-dependencies.html
[how the PRs raised should be reviewed]: https://docs.publishing.service.gov.uk/manual/merge-pr.html#dependabot
[PyUp]: https://pyup.io/
[Node.js client for the Verify Service Provider]: https://github.com/alphagov/passport-verify
[guidance on browser technology, tooling and mailing lists you can subscribe to]: https://www.gov.uk/service-manual/technology/managing-software-dependencies#managing-risks-in-third-party-code
[GitHub security alerts]: https://docs.github.com/en/code-security/supply-chain-security/managing-vulnerabilities-in-your-projects-dependencies/about-alerts-for-vulnerable-dependencies
[official base images]: https://docs.docker.com/docker-hub/official_images/
[Snyk container vulnerability management tooling]: https://snyk.io/product/container-vulnerability-management/
[GOV.UK PaaS buildpacks]: https://docs.cloud.service.gov.uk/deploying_apps.html#buildpacks
[AWS Fargate]: https://aws.amazon.com/fargate/
[RFC-167]: https://github.com/alphagov/govuk-rfcs/blob/main/rfc-167-auto-patch-dependencies.md
