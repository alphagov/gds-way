---
title: How to store and query logs
eleventyNavigation:
  parent: Logging, monitoring and alerting
last_reviewed_on: 2024-06-27
review_in: 6 months
permalink: standards/logging.html
---

You should store logs to detect any potential errors within infrastructure and
to respond to security incidents.

Use [Splunk] to store and query infrastructure, application and audit logs.

Splunk is a cloud-based SaaS tool for short and long-term storage,
visualisation, alerting, and reporting of cyber security log information.

Your product should have a proportionate design for short and long term storage of logs and ensuring the Confidentiality, Integrity, and Availability of logs.

The NCSC Cyber Assessment Framework, which GDS must comply with, has an entire category dedicated to [Security Monitoring].

### Logit deprecation notice

The shared GDS [Logit] account can still be used for existing environments;
however, you should use Splunk for new logging requirements.

Logit offers cloud-based on-demand, shared
[ELK (Elasticsearch, Logstash and Kibana)] stacks as a service. They are
suitable for short-term storage of logs, and are accessible and queryable.

## Short-term storage

You should not need to store logs spanning long periods in your short-term
queryable store. Practical retention periods for short-term queryable logs are:

* no more than 7 days for non-production environments
* no more than 30 days production environments

You should consider storing security and audit events for up to a year, this is
because the average MTTD (Mean Time to Detect) is 204 days (over 6 months) to
identify a breach, according to a [2023 IBM data breach study].

Your product may have legal or other requirements determining how long you
should store logs. For example, the
[Payment Card Industry Data Security Standard (PCI-DSS)] requires 3 months of
easily accessible logs and 12 months of archived logs.

## Long-term storage

When storing logs, you should focus on long-term durability for compliance
reasons or to identify long-term performance trends.

Splunk is appropriate for up to a year of storage. If you require more,
Splunk can be configured to [archive data to your own S3 bucket] - this saves
files in a proprietary format so consider archiving to S3 in human-readable
files using your own process.

## Log shipping

If you have set up log shipping, you should consider:

* how your logs will get to short and long-term stores - we recommend using
[Amazon CloudWatch] to collect logs and subscribing to the Cyber Security
team's [Centralised Security Logging Service (CSLS)].
* what happens if one of these stores is unavailable
* whether the store will be overloaded when it comes back online

You could have one process to ship logs to your long-term archive, and a second
process to fill a short-term query tool from the long-term archive, for example
you could combine Splunk with Amazon Cloudwatch and also archive to S3.

CSLS utilises Amazon Kinesis and can persist logs in the event that Splunk is
unavailable and will resume sending data when Splunk is available again.

Splunk Cloud's recommended input is the HTTP Event Collector (HEC) - CSLS uses
this.

Note: Splunk Cloud does not support syslog, you may need a forwarder if syslog
is your only output option:

* [Logstash HTTP output] and [HEC]
* [Fluentd to HEC]

## Filtering out sensitive information

You should ensure that sensitive information, such as query parameters containing [personally identifiable information (PII)], is filtered out before logs are shipped. Make use of log filtering mechanisms which may be present in the application framework you are using, [such as in Ruby on Rails].

## Structured logging

In order to allow for rich querying of log data you should ensure that your logs
are in a structured format.

### Stuctured logging with Splunk

[Splunk] automatically parses JSON log lines. Other formats may need [specific
field extracts] configured in Splunk.

For interoperability with pre-built apps and alerting, it is beneficial to align
your logs to the [Splunk CIM (Common Information Model)].

The [`Web` CIM] is most commonly used at GDS - it specifies particular field
names for data, for example:

  - `http_user_agent` for the client's user agent
  - `src` for the source IP address
  - `dest` for the origin server IP address

## Access to Splunk

Access control for GDS users is managed by the IT Service Desk, use the
[helpdesk] to request access. If you're unsure what role you should be
requesting, ask in the `#cyber-security-help` Slack channel.

## Advice for particular frameworks or platforms

### Dropwizard

The [dropwizard-logstash] library will set things up for you using the
standard names. Splunk will be able to ingest this format.

### GOV.UK PaaS (Cloud Foundry)

There is [broker documentation] describing how drain logs to Splunk via
[Centralised Security Logging Service (CSLS)].

The [GOV.UK PaaS Logging] documentation will help you configure Logit and
drain logs into it from your app.

[helpdesk]: https://gdshelpdesk.digital.cabinet-office.gov.uk
[Splunk]: https://gds.splunkcloud.com
[archive data to your own S3 bucket]: https://docs.splunk.com/Documentation/SplunkCloud/latest/Admin/DataSelfStorage?ref=hk#Configure_self_storage_locations
[Splunk CIM (Common Information Model)]: https://docs.splunk.com/Documentation/CIM/latest/User/Overview
[`Web` CIM]: https://docs.splunk.com/Documentation/CIM/latest/User/Web
[2023 IBM data breach study]: https://www.ibm.com/account/reg/us-en/signup?formid=urx-52258
[specific field extracts]: https://docs.splunk.com/Documentation/Splunk/latest/Data/Extractfieldsfromfileswithstructureddata
[broker documentation]: https://github.com/alphagov/tech-ops/blob/master/cyber-security/components/csls-splunk-broker/docs/user-guide.md
[Centralised Security Logging Service (CSLS)]: https://github.com/alphagov/centralised-security-logging-service
[dropwizard-logstash]: https://github.com/alphagov/dropwizard-logstash
[Logit]: https://logit.io/
[GOV.UK PaaS Logging]: https://docs.cloud.service.gov.uk/monitoring_apps.html#set-up-the-logit-log-management-service
[ELK (Elasticsearch, Logstash and Kibana)]: https://www.elastic.co/what-is/elk-stack
[Payment Card Industry Data Security Standard (PCI-DSS)]: https://www.pcisecuritystandards.org/pci_security/
[Amazon CloudWatch]: https://aws.amazon.com/cloudwatch/
[Logstash HTTP output]: https://www.elastic.co/guide/en/logstash/current/plugins-outputs-http.html
[HEC]: https://docs.splunk.com/Documentation/Splunk/latest/Data/HECExamples
[Fluentd to HEC]: https://github.com/splunk/fluent-plugin-splunk-hec
[personally identifiable information (PII)]: https://en.wikipedia.org/wiki/Personal_data
[such as in Ruby on Rails]: https://guides.rubyonrails.org/action_controller_overview.html#log-filtering
[Security Monitoring]: https://www.ncsc.gov.uk/collection/caf/cyber-assessment-framework/caf-objective-c-detecting-cyber-security-events

