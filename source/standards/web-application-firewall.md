---
title: Use a web application firewall (WAF)
eleventyNavigation:
  parent: Hosting and infrastructure
last_reviewed_on: 2023-06-27
review_in: 6 months
permalink: standards/web-application-firewall.html
---

A [web application firewall (WAF)](https://owasp.org/www-community/Web_Application_Firewall) is an application layer protection for bi-directional web-based traffic. With a WAF, you can track web traffic and use specific tools to configure access control for your web content. Doing this improves your service’s security monitoring and security position.

## Why you should use a WAF

Your continuous integration (CI) and continuous deployment (CD) pipelines should include security tests in their workflows to identify any common vulnerabilities in your code. Some common vulnerabilities like [Cross-site Scripting (XSS)](https://owasp.org/www-community/attacks/xss/) and [XML command injection attacks](https://wiki.owasp.org/index.php/Testing_for_XML_Injection_(OTG-INPVAL-008)) are still possible in your production environments due to human error.

Combining a WAF with CI and CD tools reduces the risk from those tools, and provide enhanced layered security coverage for your service.

You may also need to use a WAF because of:

- GDS or departmental policies or standards
- HMG Standards such as the [Cyber Assessment Framework][] (NCSC) or [Secure by Design Principles][] (CDDO)
- [Information Security][] requirements to minimise risk
- [Payment Card Industry Data Security Standard (PCI DSS)](https://www.pcisecuritystandards.org/) compliance
- they are generally considered basic practice for protecting public web applications

## When and how to use a WAF

Set up a baseline of tests in your project’s alpha phase to identify any security vulnerabilities. As your service’s features grow, extend your tests to cover new vulnerabilities you identify. For example, through exercises like [application threat modelling](/standards/threat-modelling.html)

[Good development practices](/) should detect and fix common vulnerabilities before they reach production environments. Use your WAF to track digital services vulnerabilities an attacker could exploit.

You should:

- have an independent security audit in place
- use established [logging techniques](/standards/logging.html)
- encrypt data at rest as well as in transit
- subscribe to and apply security patches
- use query variables instead of plain text (stored procedure) to prevent [SQL injections](https://owasp.org/www-community/attacks/SQL_Injection)

You should monitor the Open Web Application Security Project (OWASP) [top 10 most critical web application vulnerabilities](https://owasp.org/www-project-top-ten/) to keep up to date with the latest threats.

Using a WAF should align with your other security monitoring features, like [Security Information Event Management (SIEM)](https://en.wikipedia.org/wiki/Security_information_and_event_management). When developing use cases you should also factor in the extra time and resources needed to configure WAF rules.

## Managing your WAF

Identify any areas in your app not covered by your WAF and define measures to protect them, such as using:

- [alerts](#alerts) - as part of your incident management strategy
- [threat modelling](/standards/threat-modelling.html) - to assess potential weaknesses in your environment
- [reviews](#reviews) - to manage your security controls

### Alerts

It’s not always possible to block a detected attack because some services need to process transactions for any user of that service. In these situations you should [raise events as alerts](/standards/alerting.html).

When WAF alerts are raised, make sure you already have an incident policy in place, including:

- who should manage an alert
- what their responsibilities are
- how to investigate an alert
- how to tune out false positives

### Reviews

Review your WAF after each application change against the risks in the OWASP top 10 category rules.

This should be similar to how you use an [IT Health Check (ITHC)](https://www.itgovernance.co.uk/it-health-check) to test and confirm the effectiveness of security controls in your environment.

## Case study GOV.UK PaaS

A [GOV.UK PaaS](https://www.cloud.service.gov.uk/) tenant uses a pattern with [Amazon Web Services (AWS) WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html) before forwarding traffic to their apps with enabled shield advance for extra protection.

For more information read the proposed architecture for [implementing a DDoS-resistant Website using AWS Services](https://docs.aws.amazon.com/waf/latest/developerguide/tutorials-ddos-cross-service.html).

## Case study GOV.UK Pay

[GOV.UK Pay](https://www.payments.service.gov.uk/) uses a [NAXSI WAF (pay-nginx-proxy)](https://github.com/alphagov/pay-nginx-proxy) for its Nginx, forked from the Home Office.

GOV.UK Pay operates under the governance of [PCI compliance and DSS point 6.6](https://www.pcisecuritystandards.org/pdfs/infosupp_6_6_applicationfirewalls_codereviews.pdf) which states the need for web application scanning.

## Contact GDS Information Security or COD Cyber Security

Contact GDS [Information Security][] or the security architects in the COS Cyber Security team by email at [cyber.security@digital.cabinet-office.gov.uk](mailto:cyber.security@digital.cabinet-office.gov.uk) or use the [#cyber-security-help Slack channel](https://gds.slack.com/messages/CCMPJKFDK/) for help and advice.

## Further reading

To find out more about WAF refer to:

- [Open Web Application Security Project (OWASP)](https://owasp.org/) the OWASP Foundation
- [WASC OWASP Web Application Firewall](https://wiki.owasp.org/index.php/WASC_OWASP_Web_Application_Firewall_Evaluation_Criteria_Project) Evaluation Criteria Project
- [National Cyber Security Centre (NCSC)](https://www.ncsc.gov.uk/) guidance

## References

- [Information Security]: https://sites.google.com/a/digital.cabinet-office.gov.uk/gds/directorates-and-groups/cto-and-ciso-office/information-security
- [Cyber Assessment Framework]: https://www.ncsc.gov.uk/collection/cyber-assessment-framework/introduction-to-caf
- [Secure by Design Principles]: https://www.security.gov.uk/guidance/secure-by-design/
