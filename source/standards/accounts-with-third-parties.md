---
title: How to manage access to your third-party service accounts
eleventyNavigation:
  parent: Operating a service
last_reviewed_on: 2023-11-02
review_in: 6 months
permalink: standards/accounts-with-third-parties.html
---

Your GDS team probably uses third-party tools to develop a service, such as [GitHub](#managing-github-accounts) and [logit](#managing-logit-accounts). Follow this guidance to manage access to any associated accounts.

When managing third-party service accounts ensure:

* only the correct people in your team have access
* team members have account access revoked when they leave
* you identify who in your team is doing what and when (this is more important for some tools, like [Amazon CloudTrail](https://aws.amazon.com/cloudtrail/), than others like [BrowserStack](https://www.browserstack.com/)).

## Securely managing account credentials

You’re likely to need a set of credentials to gain access to your third-party user account, for example passwords or secret access keys.

When managing these credentials, you must:

* keep the number of secrets you have to a minimum - this reduces the number of credentials to revoke when someone leaves GDS (passwords are particularly problematic secrets, other secrets such as secret access keys or OAuth tokens are more easily rotated)
* never use credentials associated with another individual
* encourage the rest of your team to avoid sharing credentials unnecessarily (technical limitations may mean this is sometimes unavoidable)

### Managing accounts with organisation-level access

Often third-party services natively support organisation or team level access, for example the use of [alphagov on GitHub](https://github.com/alphagov). In these cases you should make sure only the appropriate individuals on your team have access.

With team or organisation-level accounts, where possible you should:

* create separate accounts for each individual, rather than share credentials
* use a single-sign-on provider rather than create an account with a separate username and password - preferably use G Suite as it’s a core part of the GDS leaver process, which means that access to linked third-party services will be revoked automatically when someone leaves
* make sure that you have a documented process for removing individuals’s access when they leave GDS

### Managing accounts with individual-level access

When services do not support organisation-level access, you may have to share individuals’ sign-on credentials.

Sharing individuals’ sign-on credentials can create risks as:

* you do not always know who can access a service (particularly if users only access a service rarely because you can forget who has access)
* the last person with account credentials may leave GDS, making it impossible for others to access a service in future

To reduce these risks, you should:

* create an account using a Google Group email address rather than an individual’s email address
* set posting permissions to ‘public’ so your group can receive emails from outside GDS
* set viewing topic permissions to ‘all members of the group’ so only users with access to a service are able to view posts
* [store passwords in your team’s shared credential store](/standards/storing-credentials.html)
* use two-factor authentication
* make sure you have a documented process for removing an individual’s access to the Google Group,  credential store and for rotating credentials including any API keys

## Managing GitHub accounts

When you join GDS, you will need a GitHub account. You can either use your personal account or create a new account. Either way, please [add your @digital.cabinet-office.gov.uk email address to your GitHub account](https://github.com/settings/emails). You do not need to make it the primary address or public.

Each GDS team should have someone (usually a technical lead) who is an owner and can grant/revoke access to their repositories.

## Managing Logit accounts

Use Google Apps Marketplace when you sign into Logit (this is the only available option).

## Managing Amazon Web Services (AWS) accounts

The GDS Way provides [guidance on how to access an AWS account, create a new account and account management](/manuals/working-with-aws-accounts.html).
