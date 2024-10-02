---
title: Pull requests
eleventyNavigation:
  parent: Version control and deployments
last_reviewed_on: 2023-07-21
review_in: 12 months
permalink: standards/pull-requests.html
---

Pull requests (PRs) let you tell others about changes you've pushed to a branch in a repository on GitHub.

## Why should you use pull requests?

We use [PRs][prs] at GDS to:

- enable [code review](/manuals/code-review-guidelines.html) from colleagues
- provide a lightweight change management process
- share responsibility for the code going live
- spread knowledge and make others aware of changes
- notify people outside the immediate group of reviewers

## Cautionary notes

You should not use PRs for architectural review, as you should do the architectural review before raising the PR.

It is your responsibility to make sure you get reviews for your PRs and merge them. You should not rely on someone else noticing, reviewing, and merging your PR for you.

You do not need to merge all changes for a piece of work in a single PR. You should break down the changes into several PRs to get feedback earlier.

## Guidance for each step

Feel free to ask for help on Slack (for example, [#tech-community](https://gds.slack.com/archives/CACV4GHCL)) if you are unsure how to do any of these things.

### Opening a pull request

You should make sure that:

- your local repository has the most recent changes on the target branch
- the title and description of the PR are clear and accurately represent your changes
- the title and description reference the source of the change, which could be a Zendesk ticket or a Jira card
- the description contains links to any related PRs
- any screenshots have text descriptions for accessibility
- any contentious changes or side effects have clear descriptions of the pros and cons

PRs are an implementation of change review and depend on the continued support of a repository hosting provider such as GitHub. This means that we would lose data contained in PRs if we switched providers.

As such, the canonical description of changes should be in the commit messages. You can refer to the [commit message style guide](/standards/source-code/working-with-git.html).

### Reviewing a request

Taking time to properly review a PR is as important as making the change itself, and it is crucial that we show compassion when critiquing someone else's work.

April Wensel has a talk about [Compassionate-Yet-Candid Code Reviews](https://www.slideshare.net/AprilWensel/compassionate-yet-candid-code-reviews).

It suggests 3 key questions to ask ourselves when reviewing or commenting on someone else's work:

- Is it true?
- Is it necessary?
- Is it kind?

#### Guidelines for review

Ask the PR raiser if you do not know how they want their change reviewed; they may prefer you to deliver feedback in person or while pairing.

Call out and celebrate good code, content, and design choices. This will also highlight good practice for others.

State explicitly if there are blocking issues.

#### Communicate with others who may consider reviewing the PR

Comment in the PR when discussions about the change are happening "offline" (outside the PR itself). Summarise any "offline" conversations as a comment in the PR for the benefit of others.

Comment in the PR if you have not finished reviewing the change. You might want to directly inform the PR raiser if they are expecting you to finish your review by a specific point.

#### Helpful things to consider while reviewing

Pull the branch to your local repository and try running the code; even if the tests pass, it might have bugs or unexpected side effects.

Consider the security and privacy implications of the change, paying special attention to where there is unsanitised user input or logging.

Make sure that documentation, including the README, is consistent with the code changes.

### Addressing comments

You should address any comments flagged as blocking.
This includes spelling and grammar mistakes in documentation.

You should amend minor changes into a previous commit, such as renaming a variable or adding a missing test.
You should address major changes in a separate commit.

Make sure you follow existing commit guidelines when addressing changes. "Addressed feedback" is not a helpful commit message for future contributors.

Add a comment to show you have addressed all relevant comments.

A request for refactoring, while encouraged, should not block a merge.

### Reviewing PRs from members of the public

We sometimes receive pull requests from members of the public, and we should treat them with the same compassion we would a colleague.

It is important that we also follow specific guidelines when dealing with people we do not know, some of whom will be doing this work in their own time.

#### Tone

Be positive; thank them for contributing in your first comment, even if you are going to reject their contribution.

Call out and celebrate good code, content, and design choices. A list of things to change can be dispiriting and discourage them from further contributions.

Make requests for improvement rather than telling them what to do. For example, "We think it might be better the other way round, what do you think?" rather than "Swap the order of the logic".

Be explicit and take care with what you write. People do not always understand your intentions online and cannot get in touch using Slack as a colleague might.

#### Handling the PR

You should communicate in your first comment whether we are able to merge the change.

If we do not want to merge it because it does not fit with our plans, thank them and close the PR.

If it fits, but we cannot merge it due to quality or style issues, then tell them that we are able to merge the PR if they make some changes.

We can tell the requester what improvements we'd like to see, but we should not require the contributor to make them all. For example, we might add missing tests ourselves or collaborate with them to add tests.

We should close PRs due to lack of activity but invite people to reopen them if they pick things up again.

#### Practical advice

Try to comment on changed files rather than by commit, as the notifications are easier to follow.

<%= warning_text('Do not comment on PRs outside working hours, even to acknowledge them.') %>

We do not want to set an expectation that we support making changes at night or during the weekend.

If the codebase has a changelog and the contributor has not added a line describing their change, raise a PR for this yourself after they have merged their PR.
Regardless of who has written the changelog entry, add a "Thank you `@githubusername`".

You should add a documentation credit thanking the contributor if you do not add documentation changes to the changelog.

## Further reading

- [Anna Shipman][anna] has written a useful blog post about [how to raise a good pull request][raise-pr].
- A great example of [a good pull request][good-pr] raised by [Alice Bartlett][alice].
- A useful post about [using automatic style enforcement to make pull request review more effective][style-enf] by [Paul Bowsher][paul].

[anna]: https://github.com/annashipman
[raise-pr]: https://www.annashipman.co.uk/jfdi/good-pull-requests.html
[good-pr]: https://github.com/alphagov/frontend/pull/784
[alice]: https://github.com/alicebartlett
[style-enf]: https://technology.blog.gov.uk/2016/09/30/easing-the-process-of-pull-request-reviews/
[paul]: https://mastodon.me.uk/@boffbowsh
[prs]: https://docs.github.com/en/github/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests
