---
title: Shared platform tools and services
last_reviewed_on: 2018-11-08
review_in: 6 months
---

## Reliability Engineering shared platform tools and services

Reliability Engineering provide a shared platform to distribute tools and services for GDS teams. This includes support for:

* [Amazon Web Services (AWS)](https://reliability-engineering.cloudapps.digital/iaas.html#amazon-web-services-aws)
* [GOV.UK PaaS](https://www.cloud.service.gov.uk/) infrastructure
* [Logit][] for storing and querying infrastructure and application logs
* [Prometheus][] for running an operational metrics service

Read more in the [Reliability Engineering technical documentation][] for guidance about:

### Logging

The Reliability Engineering team uses [Logit](https://logit.io) to provision, manage and ensure availability of your logging infrastructure and provide [ELK (Elasticsearch, Logstash, and Kibana)](https://www.elastic.co/elk-stack) stacks.

The Reliability Engineering team helps you integrate Logit into your environment, and create your logging and usage policies.

### Metrics and Alerting

The Reliability Engineering team is running a beta service for GDS using [Prometheus](https://prometheus.io/) for operational metrics and alerting.

Contact us on the [#re-prometheus-support](https://gds.slack.com/messages/re-prometheus-support) Slack channel to find out more.

### Amazon Web Services (AWS)

Several teams in GDS use [Amazon Web Services (AWS)](https://aws.amazon.com/) as their infrastructure provider. GDS teams manage their own AWS accounts, but users must first sign into a shared base AWS account managed by the Reliability Engineering team.

### Contact Reliability Engineering

Contact Reliability Engineering by email using [reliability-engineering@digital.cabinet-office.gov.uk][] or using the [#reliability-eng Slack channel][].

[Reliability Engineering technical documentation]: https://reliability-engineering.cloudapps.digital/
[#reliability-eng Slack channel]: https://gds.slack.com/messages/CAD6NP598/#
[Logit]: https://reliability-engineering.cloudapps.digital/logging.html#logging
[Prometheus]: https://reliability-engineering.cloudapps.digital/monitoring-alerts.html#metrics-and-alerting
[reliability-engineering@digital.cabinet-office.gov.uk]: mailto:reliability-engineering@digital.cabinet-office.gov.uk
