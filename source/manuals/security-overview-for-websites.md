---
title: Security overview for websites
eleventyNavigation:
  parent: Hosting and infrastructure
last_reviewed_on: 2024-06-27
review_in: 6 months
permalink: manuals/security-overview-for-websites.html
---

These 15 steps are primarily for running independent websites that are not on the gov.uk domain; however, the principles here apply to all Cabinet Office websites and applications.

## 1. Access Control
### Must Do

Use named accounts to log in for all systems (from registrars to content management systems).

Use Single Sign-On (SSO) wherever possible to link accounts to Google using OAuth or OIDC.
If the service does not support SSO, make sure you use a gov.uk email and enable multi-factor authentication (MFA), ideally using a phishing-resistant mechanism like WebAuthn (hardware keys).

If applicable, use more secure forms of MFA for higher risk accounts. For example, hardware tokens such as Yubikeys for privileged accounts, app-based authentication for standard accounts, and SMS MFA for low risk accounts.

Where SSO is not available, or as an additional measure where possible, consider using context-aware access controls (see [Google for example]).

Consider what monitoring and alerting should be implemented for privileged account login/use.

Have a process to review who has access regularly.

If available, enable different roles for different people’s needs.

See [how to manage access to your third-party service accounts](/standards/accounts-with-third-parties.html) for more details.

### Why?

Using named accounts makes incident response and non-repudiability (making it harder for someone to deny they were responsible) easier; if an incident occurs, named accounts make it easier to work out the cause or vector and to then restrict access.

Using SSO makes Joiners, Movers and Leavers (JML) processes simpler. As soon as someone leaves and their Google/IT account is removed, their access to services will be removed.

Using MFA prevents many common forms of attack that would otherwise give attackers access to accounts.

Context-aware access further limits unauthorised access where credentials have been compromised.

See the [NCSC's guidance on identity and access management](https://www.ncsc.gov.uk/guidance/introduction-identity-and-access-management).

## 2. Domain Name Registrar
### Must Do

Make it more challenging for adversaries to take over your registrar, which is where your domain is configured.

Contact your registrar and ask if they offer any additional safeguards to prevent takeover.

Ask your registrar for contact details that you can use in the event of an incident and note these in your incident response plan.

Enable DNSSEC if practicable ([Cloudflare has a great explanation on DNSSEC](https://www.cloudflare.com/en-gb/dns/dnssec/how-dnssec-works/)).

Ensure your WHOIS details are correct and contain the organisation or department name, the main building address, and a generic shared email address (_service_-webadmin@organisation[.]gov.uk) and do not enable privacy guard.

### Why?

If an adversary successfully gets access, they could redirect your domain to a malicious or damaging website, and it might be difficult to revert.

Having correct and available WHOIS records helps malware and security researchers understand the domain’s ownership and reach out if there’s an issue. It can also help prevent search engines from delisting or flagging the domain as spam.

## 3. Domain Name System
### Must Do

Domain Name System (DNS) is where your registrar points to, using Name Server (NS) records, and contains the records for web servers, email and other applications. DNS may be the same service as your registrar; if it’s not, follow those steps and apply them to the DNS service.

Do you need email to or from the domain name?

  - No - then make sure you disallow sending emails using the domain name; this involves adding four records (an MX and three TXT records) - see [NCSC's protecting parked domains guidance](https://www.ncsc.gov.uk/blog-post/protecting-parked-domains).
  - Yes - follow best practices (see [NCSC guidance on email security](https://www.ncsc.gov.uk/collection/email-security-and-anti-spoofing)) like setting up appropriate:
    - Sender Policy Framework (SPF) TXT record
    - Domain Keys Identified Mail (DKIM) TXT record(s)
    - Domain-based Message Authentication, Reporting, and Conformance (DMARC) TXT record, and use the [NCSC’s Mail Check](https://www.ncsc.gov.uk/information/mailcheck)

Have a process for reviewing and removing DNS records that are no longer needed.

Consider using a short Time To Live (TTL) for your main website (A or AAAA) but not too short as that can introduce vulnerabilities (5 minutes or 300 seconds is the recommended value).

Consider using longer TTLs for other records (such as email, MX or TXT records) - the recommended value is 24 hours or 86,400 seconds.

If availability is critical, consider a backup DNS; either use infrastructure as code to deploy to both or use automation to export and import the zone. Also, consider enabling the secondary DNS as another active name server.

See [how to manage DNS records for your service](/standards/dns-hosting.html#how-to-manage-dns-records-for-your-service) for more details.

### Why?

As with registrar, inadequate DNS controls could lead to an adversary pointing your domain to a malicious site or version of your site. One such attack is called [DNS hijacking](https://www.ncsc.gov.uk/news/alert-dns-hijacking-activity).

Without implementing appropriate email DNS records, you could be at risk of enabling email spam from your domain, which would impact your search results and ranking.

## 4. Patching
### Must Do

If your service uses a Content Management System (CMS), like WordPress or Joomla, or uses a non-managed infrastructure, then you - or your supplier - must have processes in place for keeping the system and software up-to-date.

Consider setting up a patching schedule with the development team or supplier to manage the patching process.
You may want to:

  - introduce this as a formal item in any governance meetings
  - consider including any periods where you may want to pause or defer patches if you are concerned about availability during key events

If you are using Infrastructure-as-a-Service (IaaS) or Platform-as-a-Service (PaaS), you may want to set up a regular pipeline that gets the latest updates, tests your website or application with those, and then pushes the tested updates to your live environment.

See [NCSC’s guidance on patching](https://www.ncsc.gov.uk/blog-post/the-problems-with-patching) for more information about patching.

### Why?

If you neglect to patch and keep the systems up-to-date, adversaries may use known vulnerabilities to impact your service.

## 5. Development, Test or Staging Environments
### Must Do

Do not overlook the security of these environments, as a compromise or incident may cause the same disruption to your development team or supplier as in the live environment.

Consider setting up an IP allowlist or additional access controls to only allow authorised people to access.

If you’re using different domains, follow the same principles listed throughout this guidance, including setting appropriate and public WHOIS information.

Do not have actual user data (logins or personal information) in these environments.

Consider removing notification ability or restricting it to designated recipients to stop accidental notifications.

## 6. Security Headers
### Must Do

Configure appropriate security headers to help your users' browsers understand what your service should be doing:

|HTTP Header|Notes
|---|---|
|Strict-Transport-Security| Also known as HTTP Strict Transport Security (HSTS), tells browsers to enforce HTTPS |
|Content-Security-Policy| [see below for details on CSP] |
|X-Content-Type-Options|When set to “nosniff” it tells browsers not to assume a content type|
|X-Frame-Options|Can defend against clickjacking|
|Referrer-Policy|Tells browsers how much information to give to third party services when a user clicks their links on your site|
|Permissions-Policy|Allows control of the browser features, such as denying access to the webcam if your website or service does not need to access it|
|Cross-Origin-Embedder-Policy|Sets the permission for how assets are loaded|
|Cross-Origin-Opener-Policy|^|
|Cross-Origin-Resource-Policy|^|
|Feature-Policy|*Partially deprecated* (see [OWASP guidance on Feature-Policy](https://owasp.org/www-project-secure-headers/#feature-policy)). Previously used to specify features the browser could access, primarily replaced with `Permissions-Policy`|
|Expect-CT|*Deprecated* (see [OWASP guidance on Expect-CT](https://owasp.org/www-project-secure-headers/#expect-ct)). Previously used by browsers to check the certificate transparency logs, which helps determine the legitimacy of a HTTPS connection. It is no longer needed as a response header|
|X-XSS-Protection|*Deprecated* (see [OWASP guidance on X-XSS-Protection](https://owasp.org/www-project-secure-headers/#x-xss-protection)). Previously used to mitigate XSS (cross-site scripting), this has been deprecated and should be set to `0` to disable the functionality in older browsers|

Remove/disable the “Server” header; this is slightly contradictory to the [NCSC’s Secure by Design principle](https://www.ncsc.gov.uk/information/secure-default) of “security through obscurity should be avoided” but it does make it more challenging to target your service.

You can find an example of implementing the headers using Lambda@Edge in the [alphagov/aws-lambda-at-edge-examples] repo.

Use <https://securityheaders.com> to check your security headers - tick the “Hide results” checkbox before clicking “Scan”.

### Why?

Security headers help users' browsers determine the intended functionality of your website or service and make it more difficult for an adversary to cause an incident.

## 7. Content Delivery Network
### Should Do

Along with [Access Control] for the provider, make it harder to cause a denial-of-service attack against your service by using a Content Delivery Network (CDN), such as AWS Cloudfront.

Configure appropriate caching so that the CDN can serve most, if not all, traffic.

Consider a backup CDN, and this could be as simple as a static version; see [Backup Static Origin] for more details.

Implement origin access controls so that the origin cannot be impacted directly. The recommended approach in AWS is to add a 'secret’ header from the CDN to the origin and have the origin check that header in an AWS WAF rule.

If you are using CloudFront:

1. Consider limiting the edge locations if you only expect traffic originating from the UK.
2. Set up AWS Shield Advanced (it’s paid for and already available in Cabinet Office’s AWS environment), see [AWS Shield Response Team]
3. Contact the [CDIO Cyber Security] team to send logs and get access to Splunk - see the [logging](/standards/logging.html) page for more details.
4. Consider setting up AWS Origin Shield if you expect international traffic.

### Why?

Good caching reduces the risk of a Distributed Denial-of-Service (DDoS) impacting your website or service.

A backup or secondary origin can mitigate a complete outage of your primary site for extended periods.

The origin access control prevents the CDN from being bypassed and traffic going directly to the origin servers, where they could be quickly overwhelmed by a DDoS attack. By implementing the control as an AWS WAF rule, traffic does not go to your origin servers; AWS scalable infrastructure handles it instead.

## 8. Third-Party Assets
### Should Do

Unless you have a valid use case, do not use web assets, particularly JavaScript, hosted by a third party, such as the jQuery CDN. Using these introduces a vulnerability to users of your service that you cannot control; it also slows down your site.

## 9. Content Security Policy
### Should Do

Content Security Policy (CSP) is one security header that tells browsers where a website should be loading resources and which resources it should be loading.

Follow these steps to configure:

1. Enable CSP in “Report-Only” mode by setting the Content-Security-Policy-Report-Only header and enable the reporting mechanism.
2. See the [alphagov/browser-listener] GitHub repo for a central reporting tool.
3. Review the browser developer console and Splunk logs and use those to tune the CSP configuration.
4. Change the header to Content-Security-Policy so that browsers can prevent potentially malicious activity.

### Why?

Suppose an adversary discovers a vulnerability, such as cross-site scripting (XSS). In that case, they could include content or links to their malicious website - CSP helps prevent this by reducing the successful options available to an attacker.

## 10. Implement security.txt
### Should Do

See [vulnerability disclosure] for information on how to configure.

You can find an example of implementing a redirect using Lambda@Edge in the [alphagov/aws-lambda-at-edge-examples] GitHub repo.

You can check the configuration using <https://findsecuritycontacts.com/query>.

### Why?

A security.txt file helps malware or security researchers contact the Cyber Security team if there’s an issue found on the site.

## 11. Web Application Firewall
### Should Do

Make it more difficult to exploit a weakness in your service which could cause you an incident by enabling a Web Application Firewall (WAF).

If you have dynamic content that takes user input, you should enable AWS WAF and apply appropriate rules.
For example, if you are running WordPress, you may want to enable the managed PHP and “AWSManagedRulesWordPressRuleSet” rulesets, but “AWSManagedRulesWindowsRuleSet” is likely inappropriate as WordPress does not typically run on Windows.

Even if you do not have dynamic content, a WAF - even one with no enabled rules - can be helpful if you have ever have an incident in future by allowing for quick configuration.

Make sure you test after enabling WAF rules so they do not impact usability.

See more information on the [Use a web application firewall (WAF)](/standards/web-application-firewall.html) page.

## 12. AWS Shield Response Team
### Should Do

If you use the Cabinet Office AWS environment:

Enable the AWS Shield Response Team (SRT), previously known as DDoS Response Team (DRT), against applicable resources like CloudFront and Application Load Balancers (ALBs) - see the [Amazon documentation on Shield Advanced and the SRT](https://docs.aws.amazon.com/waf/latest/developerguide/authorize-DRT.html).

You likely need to configure the following:

  - DRT IAM (Identity and Access Management) role
  - Route53 DNS health check(s)
  - blank WAF(s)
  - Proactive Engagement - ask the [CDIO Cyber Security] team for contact information to input here

### Why?

The Cabinet Office pays for an enhanced service (Shield Advanced), enabling AWS to support us when certain attacks impact our web services. This allows us to utilise AWS’ expertise and take some of the pressure off when there’s an incident. Without this, your website or service may be unavailable for longer while mitigating malicious activity.

## 13. Vulnerability Scanning
### Should Do

Find out about potential weaknesses early.

Sign up to NCSC’s Web Check service with your gov.uk email address to have NCSC scan and report common findings to you: <https://www.ncsc.gov.uk/information/web-check>.

Contact the [CDIO Cyber Security] team to have regular vulnerability scanning enabled.

Use <https://www.ssllabs.com/ssltest> to check your Transport Layer Security (TLS) settings (formerly known as SSL or Secure Sockets Layer) - tick the “Do not show the results on the boards”.

### Why?

Vulnerability scanning gives you an insight into what common weaknesses are present in your website or service; this may allow you to patch or mitigate the weakness before it’s exploited and becomes an incident.

## 14. Backup Static Origin
### Could Do

Have a simple static version of your site with reduced functionality; this could be used in the event of a CDN outage or if your dynamic origin becomes unavailable.

You could implement a scraper in AWS Lambda to regularly take a copy of your dynamic site. The scraper could filter only your domain or relative URLs, disable any forms (remove the form action and disable the submit button), and then upload the contents to a public S3 bucket.

## 15. Usage Analytics
### Could Do

Consider using server analytics instead of remote analytics.

If you use remote analytics and handle sensitive data, such as user login, you should not include the remote JavaScript (as is the case with Google Analytics) on those paths.

### Why?

Remote analytics, such as Google Analytics, introduces a vulnerability to your service and requires relaxing the content security policy. It can also slow down the site for users with slow devices or where they have low bandwidth.


[Access Control]: #1-access-control
[see below for details on CSP]: #9-content-security-policy
[AWS Shield Response Team]: #12-aws-shield-response-team
[Backup Static Origin]: #14-backup-static-origin
[alphagov/aws-lambda-at-edge-examples]: https://github.com/alphagov/aws-lambda-at-edge-examples
[alphagov/browser-listener]: https://github.com/alphagov/browser-listener
[CDIO Cyber Security]: https://gds.slack.com/messages/CCMPJKFDK/
[vulnerability disclosure]: /standards/vulnerability-disclosure.html
[Google for example]: https://workspaceupdates.googleblog.com/2022/04/context-aware-access-admin-console.html
