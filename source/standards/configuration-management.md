---
title: Use configuration management
eleventyNavigation:
  parent: Hosting and infrastructure
last_reviewed_on: 2022-09-25
review_in: 6 months
permalink: standards/configuration-management.html
---

Use [configuration management][] to manage, automate and standardise your infrastructure. When using configuration management you store your [infrastructure as code][] in a version control system such as Git.

## Puppet

The use of [Puppet][] at GDS is diminishing as we move more of our infrastructure to containers and higher level services. It's mainly still in use on [GOV.UK](https://github.com/alphagov/govuk-puppet) but this will decline as more services are moved over to AWS EKS.

If your environment consists of a simple deployment artefact like an [Amazon Machine Image (AMI)][], Puppet may not be necessary, but the process for building that artefact must still be codified and version controlled.

## Terraform

Use [Terraform][] to configure third party cloud infrastructure like Amazon Web Services (AWS) or [Fastly][].

Terraform supports a [large number of providers][], and you can configure it to support multiple environments with different parameters. See the [govuk-aws][] repository as an example.

### Versioning

Due to the high rate of change in many cloud provider offerings we
recommend you keep your Terraform versions and codebases up to date. A
version manager such as [tfenv](https://github.com/tfutils/tfenv),
already used by a number of GDS teams, can help you with supporting
multiple versions.

### Code analysis

There are a number of Terraform focused static analysis tools in use at
GDS. While none of them are yet ubiquitous they can help ensure your
code is more idiomatic, consistent and secure and you should consider the
benefits they could bring to your build pipelines.

 * [checkov](https://github.com/bridgecrewio/checkov) - "detects security and compliance misconfigurations"

 * [tfsec](https://github.com/aquasecurity/tfsec) - "spots potential security issues"

 * [tflint](https://github.com/terraform-linters/tflint) "linter focused on possible errors, best practices and so on."

## Further reading

Find out more about configuration management in the [Service Manual][].

[configuration management]: https://www.digitalocean.com/community/tutorials/an-introduction-to-configuration-management
[infrastructure as code]: https://www.gov.uk/service-manual/technology/manage-your-software-configuration#use-infrastructure-as-code
[Amazon Elastic Compute Cloud (Amazon EC2)]: https://aws.amazon.com/ec2/
[Amazon Machine Image (AMI)]: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html
[Terraform]: https://www.terraform.io/
[Puppet]: https://puppet.com/
[Service Manual]: https://www.gov.uk/service-manual/technology/manage-your-software-configuration#using-configuration-management-tools
[Fastly]: https://www.fastly.com/
[govuk-aws]: https://github.com/alphagov/govuk-aws
[large number of providers]: https://www.terraform.io/docs/language/providers/index.html
