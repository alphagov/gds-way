---
title: How to store credentials
eleventyNavigation:
  parent: Operating a service
last_reviewed_on: 2023-11-02
review_in: 6 months
permalink: standards/storing-credentials.html
---

Depending on how you [manage your accounts](/standards/accounts-with-third-parties.html), you, your team and the service you run may have credentials or other secrets that you need to store securely.

## Personal credentials

Personal credentials belong only to you. They uniquely identify you and grant access to your GitHub, AWS, and GOV.UK Signon accounts.

[If possible, use the password manager built into your browser](https://lock.cmpxchg8b.com/passmgrs.html#conclusion). This is simpler than setting up an extra account with a third party and avoids the potential issues below.

If you are unable to use your browser's password manager then you should use a third-party password manager. This could be necessary if your browser has an accessibility issue, or if you work with multiple browsers.

Third-party password managers used by people at GDS include:

- [**1Password**](https://1password.com/)
- [**BitWarden**](https://bitwarden.com/) - An open source password manager.
- [**KeePassXC**](https://keepassxc.org/) - An offline password store, which you may want to backup somewhere.
- [**QtPass**](https://qtpass.org/) - Another offline store, integrated with Git and GPG / pass.

There is a security trade-off involved in using browser extensions to autofill credentials.

Auto-filling credentials can protect against phishing attacks. Your password manager will refuse to autofill credentials for the wrong site, such as `exxample.com` attempting to impersonate `example.com`. However, it can be [difficult to implement this functionality securely in an extension](https://lock.cmpxchg8b.com/passmgrs.html#interprocess-communication).

## Team credentials

Credentials sometimes need to be shared across a team or programme. Software repositories (NPM, RubyGems, Maven Central) and admin portals (Fastly, DockerHub) will often have shared credentials.

[You should follow the guidance for managing team credentials.](/standards/accounts-with-third-parties.html).

We have no established best practice for storing shared credentials at GDS. Some teams have a "credentials" GitHub repository and use [pass](https://www.passwordstore.org/) or [blackbox](https://github.com/StackExchange/blackbox) to store credentials encrypted with GPG.

<%= warning_text('Make sure you configure the repo as <a href="https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/about-repository-visibility">internal or ideally private</a> to help prevent accidental disclosure') %>

Investigate alternatives before adopting GPG-based credential stores for new teams.

- We cannot revoke access to GPG-based credentials unless we change them. Anyone with access can still decrypt credentials using their local copy of the repo and its commit history.

- It creates a high barrier to entry as GPG tools are [generally difficult to use](https://latacora.micro.blog/2019/07/16/the-pgp-problem.html) and key-servers are unreliable.

The GOV.UK Design System and Prototype Kit teams have recently set up a [Bitwarden](https://bitwarden.com) organisation as a replacement for their credentials repository.

## Service credentials

Deployed services sometimes need sensitive configuration such as API keys and IP block lists.

Use the secret management feature of your infrastructure or cloud provider e.g. [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/getting-started/), [HashiCorp Vault](https://www.vaultproject.io/). This should make it easy to control and audit access to the credentials.

Older projects in GDS might have a "secrets" repository and use GPG to encrypt files, which are then decrypted during the deployment process. This approach should not be used unless there is no better option.
