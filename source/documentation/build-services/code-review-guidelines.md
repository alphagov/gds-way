---
title: How to review code
last_reviewed_on: 2018-06-04
review_in: 6 months
---

## How to review code

Comprehensive reviews help to keep code maintainable and reusable, and reveal gaps in documentation. You should use the [GitHub review][] feature with [pull requests (PRs)][] wherever possible.

### Good review practice

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
* ask for clarification on anything that is not clear

You should not:

* rush a review, even if it’s urgent
* repeatedly point out the same error pattern
* leave comments without context

### Programming style

Good code should adhere to the principles of its language, for example [The Zen of Python][].

You should consider if the code in a PR has:

* an applicable edge case
* patterns consistent with similar code elsewhere in the codebase
* readable variable names, accurately representing their contents
* missing or additional elements following a merge or rebase
* capacity for reusability

You should always check code for linting issues. You could consider running automated linting before merging PRs, for example with [Travis CI][].

### Code libraries

If a PR involves changes to libraries, you should check that the:

* changes are backwards compatible
* version number has been updated
* changelog has been updated, especially if there are major problems

### Third-party dependencies

You should make sure that new or updated third-party dependencies are from reliable and stable sources, and that they do not break any existing code. You should also make sure that they are needed, and that they are wherever possible.

You can read more about [how to manage third party software dependencies here][].

### Testing

Code changes should have appropriate test coverage. You should consider running tests as part of your review, and check that:

* all possible error cases are covered
* the tests pass in all appropriate environments
* test names describe what’s happening in the test

You should consider if unit tests are enough, or if you need integration tests.

### Deployment

You should consider whether code changes will impact the deployment process, and check that they:

* are self-contained
* do not adversely affect other applications and systems
* do not have any potential security issues
* will deploy properly

The Service Manual contains some guidance about [deploying software][].

### Documentation

Before you approve a PR, you should consider if it affects any existing documentation. If the PR itself contains documentation, you should make sure that it’s clear and unambiguous, and in the right place.

If you want to learn more about writing clearly for technical audiences you can contact GDS technical writers using the [#ask-technical-writers Slack channel][].

### Further reading

You can find out more about how to review code by reading:

* the pull requests [style guide for working on GOV.UK][]
* checklists for [code authors and reviewers][]
* how to do [code reviews like a human][]
* about writing [review comments positively][]
* about [collated feedback and data][] from a developer survey



[GitHub review]: https://help.github.com/articles/about-pull-request-reviews/
[pull requests (PRs)]: https://help.github.com/articles/about-pull-requests/
[technical debt]: https://insidegovuk.blog.gov.uk/2018/02/19/classifying-and-measuring-tech-debt-in-gov-uk/
[programming language style guides]: #programming-language-style-guides
[The Zen of Python]: https://www.python.org/dev/peps/pep-0020/
[Travis CI]: https://travis-ci.org/
[how to manage third party software dependencies here]: build-services.html#manage-third-party-software-dependencies
[deploying software]: https://www.gov.uk/service-manual/technology/deploying-software-regularly
[style guide for working on GOV.UK]: https://github.com/alphagov/styleguides/blob/master/pull-requests.md#reviewing-a-request
[code authors and reviewers]: https://engineeringblog.yelp.com/2017/11/code-review-guidelines.html
[code reviews like a human]: https://mtlynch.io/human-code-reviews-1/
[review comments positively]: https://codeahoy.com/2016/04/03/effective-code-reviews/
[collated feedback and data]: http://www.bettercode.reviews/
[#ask-technical-writers Slack channel]: https://gds.slack.com/messages/CAD579Y1X/#
