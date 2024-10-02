---
title: How to review code
eleventyNavigation:
  parent: Software development
last_reviewed_on: 2023-11-02
review_in: 9 months
permalink: manuals/code-review-guidelines.html
---

Comprehensive reviews help to keep code maintainable and reusable, and reveal gaps in documentation. Use the [GitHub review][] feature with [pull requests (PRs)][] before merging code. The author is responsible for obtaining a code review, and merging the pull request.

## Good review practice

You should consider whether PRs:

* have a clear purpose
* capture the simplest way to solve a problem
* suggest changes outside a project’s scope
* need breaking into smaller PRs

You should also consider if a PR’s suggested changes will contribute to [technical debt][], and if you can make suggestions to help solve existing technical debt.

When you suggest changes, you should explain your reasoning and refer to [programming language style guides][] where appropriate. You may find it useful to provide short examples to explain your suggestions.

You should:

* only approve pull requests you fully understand
* give appropriate positive feedback
* flag up major issues quickly, and in person if necessary
* ask for clarification on anything that's not clear

You should not:

* rush a review, even if it’s urgent
* repeatedly point out the same error pattern
* leave comments without context

## Programming style

Good code should follow the principles of its language. See [Programming language style guides][] for more information.

You should consider if the code in a PR has:

* an applicable edge case
* patterns consistent with similar code elsewhere in the codebase
* readable variable names, accurately representing their contents
* missing or additional elements following a merge or rebase
* capacity for reusability

You should always check code for linting issues. You could consider running automated linting before merging PRs, for example with [GitHub Actions][].

## Code libraries

If a PR involves changes to libraries, you should check the:

* changes are backwards compatible
* version number has been updated
* changelog has been updated, especially if there are major problems

## Third-party dependencies

You should make sure that new or updated third-party dependencies are from reliable and stable sources, and that they do not break any existing code. You should also make sure they are needed, and are [open source][] wherever possible.

You can read more about [how to manage third party software dependencies here][].

## Testing

Code changes should have appropriate test coverage. You should consider running tests as part of your review, and check that:

* all possible error cases are covered
* the tests pass in all appropriate environments
* test names describe what’s happening in the test

You should consider if unit tests are enough, or if you need integration tests.

## Deployment

You should consider whether code changes will impact the deployment process, and check that they:

* do not adversely affect other applications and systems
* do not have any potential security issues
* will deploy properly

The Service Manual contains guidance about [deploying software][].

## Documentation

Before you approve a PR, you should consider if it affects any existing documentation. You should make sure the PR's documentation is clear and unambiguous, and in the right place.

If you want to learn more about writing clearly for technical audiences you can contact GDS technical writers using the [#gds-technical-writing Slack channel][].

## Further reading

Find out more about writing and reviewing pull requests on the [Pull requests page][].

[GitHub review]: https://docs.github.com/en/github/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/about-pull-request-reviews
[pull requests (PRs)]: https://docs.github.com/en/github/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests
[technical debt]: /standards/technical-debt.html
[programming language style guides]: /manuals/programming-languages.html
[open source]: /standards/publish-opensource-code.html
[how to manage third party software dependencies here]: /standards/tracking-dependencies.html
[deploying software]: https://www.gov.uk/service-manual/technology/deploying-software-regularly
[Pull requests page]: /standards/pull-requests.html
[GitHub Actions]: /standards/source-code/use-github.html#using-github-actions-and-workflows
[#gds-technical-writing Slack channel]: https://gds.slack.com/archives/CAD0R2NQG
