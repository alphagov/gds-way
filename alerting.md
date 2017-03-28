# Alerting

This document is current until 1 October 2017.

Services at GDS need to be set up to send automated alerts
to staff if the service's monitoring detects issues.

Alerts can take many forms including dashboards, emails,
phone calls and status websites.

The service manual has [some information on writing alerts][service_manual_alerts].

[service_manual_alerts]: https://www.gov.uk/service-manual/technology/monitoring-the-status-of-your-service#writing-alerts

## User needs for alerting

- Support GDS' goal of services being available to meet user needs
- Mitigate reputational damage to GDS
- Adhere to service level agreements (with reliant parties like other government departments), industry standards (like PCI compliance) and legal requirements (like the [Code of Practice for Official Statistics][stats_law])

[stats_law]: https://gss.civilservice.gov.uk/about/code-of-practice/

## Principles for setting up an alerting system

Alerts should be meaningful and actionable. An alert that shows
the status of a system is actually a monitoring tool. The text of
your alerts should be specific - people will be responding to alerts
in the middle of the night.

Abandon the use of emails as an alerting method. Emails become noisy
which over time results in them being ignored or overlooked. If you
absolutely have to use emails, template them so that the information
is presented consistently.

Consolidate multiple dashboards into one to have an authoritative
source to check for alerts.

People respond better to their preferred alerting method. Use a tool
which allows your on-call staff to have the same alert presented in
different ways depending on the responder.

The audience for your alerts should dictate which alerting
mechanism to use. Sending an SMS to all of your users when
you have an outage might be impractical, but setting up
a status page is probably sensible.

Do end-to-end tests of your alerting pipeline regularly.

As a team grows or becomes more mature, it becomes more important to
track alerts, escalate them (automatically or manually), acknowledge them
(as work in progress) and co-ordinate rotas.

## Tools for alerting

Several teams at GDS use [PagerDuty](https://www.pagerduty.com/) to be
alerted of problems with their service.

Several teams use [Pingdom](https://www.pingdom.com/) as well
in case PagerDuty becomes unavailable.

A couple of teams use [Atlassian StatusPage](https://www.statuspage.io/) to
provide updates on service status to users.

[Dashing](http://dashing.io/) and [Smashing](https://github.com/Smashing/smashing)
are good tools to use for creating dashboards.
