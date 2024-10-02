---
title: Use GitHub
eleventyNavigation:
  parent: How to store source code
last_reviewed_on: 2023-12-08
review_in: 6 months
permalink: standards/source-code/use-github.html
---

GDS uses the [alphagov] organisation on [GitHub] to collaborate on code. The GOV.UK One Login programme uses [govuk-one-login].

### Getting access to `alphagov`

You can use your personal GitHub account to access alphagov if you wish.

All github user accounts added to `alphagov` *must* be [connected](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/adding-an-email-address-to-your-github-account) with a valid `digital.cabinet-office.gov.uk` email address. Accounts not connected to a valid email address will be removed from `alphagov`.

You must also set up two-factor authentication on your account.

To join `alphagov` ask your tech lead or technical architect to invite you. Make sure you've connected your GDS email address to your account first, otherwise your account will be removed.

### Configuring GitHub repositories

Consider [protecting your main branch](https://docs.github.com/en/github/administering-a-repository/defining-the-mergeability-of-pull-requests/about-protected-branches) to prevent changes being committed without a suitable review.

You can also consider backing up your Git repositories to another location (this should be a team responsibility). If you are using AWS to host your service
[AWS CodeCommit](https://aws.amazon.com/codecommit/) is one option.

### How to retire applications

If an application is no longer used in production, you should [archive its repository](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/archiving-a-github-repository/archiving-repositories).

Update the application's README to explain why the repository has been archived, and link to a new location if the application has been superseded.

### Using Github Actions and workflows

Alphagov repositories can be configured to use [GitHub Actions](https://docs.github.com/en/actions) for CI/CD jobs, for example running unit tests or deploying a static site.

Actions and workflows can be powerful, so take care to follow best security practice.

Ensure the repository permissions follow [the principle of least privilege](/standards/principle-least-access.html) by:

- disabling Actions entirely on repositories that do not use it (this will hide the 'Actions' tab from the repository menu)
- setting workflow permissions to read-only by default
- setting [granular permissions in the workflow YAML](https://docs.github.com/actions/reference/authentication-in-a-workflow#modifying-the-permissions-for-the-github_token) where appropriate
- [using environments to restrict access to secrets](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#environment-secrets)

If your repository has external contributors, [ensure they do not have permissions to add workflows or trigger workflow runs](https://docs.github.com/en/actions/managing-workflow-runs/approving-workflow-runs-from-public-forks).

If your workflow interacts with another resource (for example AWS or DockerHub), consider setting up a dedicated account or role, with permissions limited to the scope of the action.
Use temporary credentials in preference to storing long-lived credentials in a secret.
In particular, when accessing AWS you must [authenticate using the OpenID Connect token](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services) and not using an IAM User's access key and secret access key.
You should also specify the branch you expect to be deploying from (for example, `main`) in your IAM role to make sure code cannot be deployed from untrusted branches.

Consider protecting the `.github/workflows` folder by using [a CODEOWNERS file](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners) and requiring review from CODEOWNERS for merges into protected branches.

Consider creating a Workflow Template in the [alphagov workflow folder](https://github.com/alphagov/.github/tree/main/workflow-templates) if you need to share a similar workflow between many repositories.

[Create your own local actions](https://docs.github.com/en/actions/creating-actions/about-actions) wherever possible. If using GitHub-owned actions, [pin to a specific version](https://docs.github.com/en/actions/learn-github-actions/finding-and-customizing-actions#using-release-management-for-your-custom-actions).
Third-party actions should only be used if:

- The provider is verified by GitHub (for example, [aws-actions](https://github.com/aws-actions))
- The action is complex enough that you cannot write your own local action
- You have fully reviewed the code in the version of the third-party action you will be using
- You have pinned the specific version in your workflow and in the repository settings, using a Git commit SHA
- The third-party action is actively maintained, well-documented and tested ([follow the guidance on third party dependencies](/standards/tracking-dependencies.html)).

You can enforce this in the settings for Actions by choosing ['Allow select actions'](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#allowing-specific-actions-to-run) and then 'Allow actions created by GitHub' and 'Allow Marketplace actions by verified creators' as required.

Note that for public repositories, the output of workflow runs is visible to everyone. Do not use workflows if this output could be considered sensitive.

### Access GitHub support

The alphagov organisation is covered under the Cabinet Office's [GitHub enterprise support agreement][]. Under this agreement GitHub will respond to support requests within eight hours, Monday to Friday.

To access enterprise support you need either to be an enterprise admin or have been granted a support entitlement by an enterprise admin. There can only be a maximum of 20 people across the enterprise who have the support entitlement, so not everyone can have this.

#### Request support

If you are not already an enterprise admin or have a support entitlement on your GitHub user you will first need to ask one of the enterprise admins to be given permissons to access the support portal. You can do this by emailing the [GDS GitHub enterprise owners google group].

Once you've been given permission, you can view and raise support requests using GitHub's [support portal].

You should use your `@digital.cabinet-office.gov.uk` email during the sign up process to ensure your ticket is prioritised. You should also state that you are part of alphagov organisation in your request.

[GitHub enterprise support agreement]: https://help.github.com/en/github/working-with-github-support/github-enterprise-cloud-support
[support portal]: https://support.github.com/
[GDS GitHub enterprise owners google group]: mailto:gds-github-enterprise-owners@digital.cabinet-office.gov.uk

## See also

* [How to store source code](index.html)
* [Working with Git](working-with-git.html)

[GitHub]: https://technology.blog.gov.uk/2016/05/31/how-we-use-git-at-the-government-digital-service/
[alphagov]: https://github.com/alphagov/
[govuk-one-login]: https://github.com/govuk-one-login