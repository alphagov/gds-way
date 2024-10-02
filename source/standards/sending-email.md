---
title: How to send email notifications
eleventyNavigation:
  parent: Operating a service
last_reviewed_on: 2022-10-26
review_in: 6 months
permalink: standards/sending-email.html
---

At GDS you should use the following standards for sending email notifications to service users and engineers.

## How to send notifications to users

Use [GOV.UK Notify](https://www.notifications.service.gov.uk/) when sending notifications to users from a GDS service, for example password resets and confirmation emails.

There's a [complete feature list](https://www.notifications.service.gov.uk/features) available of what you can do with GOV.UK Notify, and you can also register for [a Notify account](https://www.notifications.service.gov.uk/register) here.

The Service Manual has further information related to [sending emails from your service domain](https://www.gov.uk/service-manual/technology/how-to-email-your-users).

## How to send notifications to engineers

Use an [alerting], [monitoring] or [logging] tool when you need to send automatic notifications from systems like [Cron](https://en.wikipedia.org/wiki/Cron) or [Jenkins](https://www.jenkins.io/) to engineers.

To reduce inbox noise which can result in emails being ignored or overlooked, you should only use automatic email notifications from systems when the issue can’t be picked up through monitoring or logging. In these situations send email using [Amazon Simple Email Service (Amazon SES)](https://aws.amazon.com/ses/).

[alerting]: alerting.html
[monitoring]: monitoring.html
[logging]: logging.html
