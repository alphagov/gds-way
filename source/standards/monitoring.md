---
title: How to monitor your service
eleventyNavigation:
  parent: Logging, monitoring and alerting
last_reviewed_on: 2023-11-27
review_in: 3 months
permalink: standards/monitoring.html
---

In Cabinet Office Digital and GDS, we follow the Service Manual guidance on how to [monitor the status of services][] and set [performance metrics][].

We recommend using [Pingdom][] to monitor your service’s availability from outside our network. To further make sure your service is working, you should:

* run regular [smoke tests][] using a browser automation app such as Selenium
* implement a tool to ensure user journeys are working as you expect
* monitor applications for errors using an error tracking app such as [Sentry][]
* implement configuration management to set up repeatable monitoring

## Using metrics-based monitoring

Collecting metrics on the performance of your service is useful for [capacity planning][] and autoscaling. You should apply metrics-based monitoring to measure aggregated numerical data about your service and create [Grafana][] dashboards to view metrics from your datasource, for example related to your infrastructure or application.

We recommend using [Prometheus][] to gather metrics and monitor your service, as this is what many GDS teams are using. Amazon provides a [Managed Prometheus service][], which you may wish to use instead of hosting Prometheus yourself. You may also consider using [CloudWatch Metrics][] instead for simpler use-cases where the complexity of Prometheus is not required.

[monitor the status of services]: https://www.gov.uk/service-manual/technology/monitoring-the-status-of-your-service
[performance metrics]: https://www.gov.uk/service-manual/measuring-success/how-to-set-performance-metrics-for-your-service
[Pingdom]: https://www.pingdom.com/
[smoke tests]: https://www.gov.uk/service-manual/technology/deploying-software-regularly#using-smoke-tests-after-you-deploy
[Sentry]: https://sentry.io/welcome/
[capacity planning]: https://www.gov.uk/service-manual/technology/test-your-services-performance#start-with-capacity-planning
[Grafana]: https://grafana.com/
[Prometheus]: https://prometheus.io/
[CloudWatch Metrics]: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/working_with_metrics.html
[Managed Prometheus service]: https://aws.amazon.com/prometheus/
