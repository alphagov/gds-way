---
title: Operating systems for virtual machines
eleventyNavigation:
  parent: Hosting and infrastructure
last_reviewed_on: 2023-11-15
review_in: 12 months
permalink: standards/operating-systems.html
---

## Amazon Web Services virtual machines

If you're using [AWS EC2](https://aws.amazon.com/ec2/) and you do not require a Debian-based system, you should use [Amazon Linux 2 LTS](https://aws.amazon.com/amazon-linux-2/release-notes/) as your operating system (OS).

Amazon Linux 2 was forked from `RHEL`/`CentOS` and the primary package manager is [`yum`](http://yum.baseurl.org/wiki/Guides.html). It's mantained by Amazon and includes a Kernel tuned for enhanced performance on EC2. The OS is available as a [virtual machine image](https://cdn.amazonlinux.com/os-images/latest/) and [Docker image](https://hub.docker.com/_/amazonlinux/) for testing.

## Non-AWS and Debian virtual machines

If you're not using AWS, or you need to use a Debian-based OS, you should use [Ubuntu LTS](https://ubuntu.com/download/server) as an OS for your virtual machine (VM).

GDS recommends using Long Term Support (LTS) versions as the default choice for your VM OS. If you're running the latest LTS release and there are newer features not available in that release, such as newer kernels, consider using the official backports or trustworthy PPA sources rather than upgrading the whole OS to a standard (non-LTS) release.

You must make sure these backports and other sources receive regular and timely security updates. This should be less of a burden than having to update the OS on VMs every 6 to 9 months.

If you do use standard Ubuntu, you must migrate to the latest release within 3 months to ensure you stay within the support period and receive security updates. You must consider this carefully when proposing adopting standard Ubuntu releases as it can affect the stability of your running service. 

Standard releases only receive security updates for 9 months after their initial release. LTS receives support for 5 years, or longer with paid-for extended support.

## Hardening

You must apply hardening to your operating system. The National Cyber Security Centre (NCSC) [Cyber Assessment Framework] has a specific objective for this (B4.b). 

For example, you should disable root SSH access and deny SSH access using a password. You must also make sure your OS is:

* automatically updated for security issues
* up to date with the latest OS releases
* able to run on a local VM

The NCSC has principles to follow for [end user device (EUD) hardening](https://www.ncsc.gov.uk/collection/device-security-guidance/security-principles).

The NCSC also has guidance on [hardening that's specific to the latest Ubuntu LTS version](https://www.ncsc.gov.uk/collection/device-security-guidance/platform-guides/ubuntu-lts).

The Center for Internet Security also publishes the [CIS Benchmarks], which provide a full breakdown of hardening options for specific operating systems, as well as other firmware.

[Cyber Assessment Framework]: https://www.ncsc.gov.uk/collection/caf/cyber-assessment-framework/caf-objective-b-protecting-against-cyber-attack
[CIS Benchmarks]: https://www.cisecurity.org/cis-benchmarks
