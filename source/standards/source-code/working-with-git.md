---
title: Working with Git
eleventyNavigation:
  parent: How to store source code
last_reviewed_on: 2024-05-01
review_in: 9 months
permalink: standards/source-code/working-with-git.html
---

## Default branch name

Your repository's default branch should be called `main`.

To configure git to use `main` for new repositories, first make sure you are using git 2.28 or later, then run:

    git config --global init.defaultBranch main

To migrate existing repositories from `master` to `main`, you can use
[GitHub's branch renaming
tool](https://github.com/github/renaming#renaming-existing-branches).

Before you rename your default branch, you should consider the impact this will have on:

 - internal users
 - external users
 - your continuous integration (CI) system (for example, Concourse pipelines or GitHub actions)

You can configure some CI systems to check out the default branch rather than hardcoding a branch name:

 - [GitHub Actions](https://github.blog/changelog/2020-07-22-github-actions-better-support-for-alternative-default-branch-names/) supports a `$default-branch` macro
 - [concourse-git-resource](https://github.com/concourse/git-resource): if you do not set `branch`, it will check out the default branch

## Commits

### Atomic commits

Each commit should be atomic - this means that each commit:

* is self-contained
* only includes changes that achieve a specific step
* should be in a logical order

As Anna Shipman describes it,
[they should tell a story](https://www.annashipman.co.uk/jfdi/good-pull-requests.html#make-the-pull-request-tell-a-story).

#### Example

From Anna's blogpost, we see an example of how a [single commit with 51 files changed](https://github.com/alphagov/paas-alpha-tsuru-ansible/commit/7547ac0d35a)
was broken down into a [series of 8 commits implementing those changes](https://github.com/alphagov/paas-alpha-tsuru-ansible/compare/d891857...d14bb2f44) instead.

### Commit messages

Writing good commit messages is important. Not just for yourself, but for other
developers on your project. This includes:

* new (or recently absent) developers who want to get up to speed on progress
* interested external parties who want to follow progress of the project
* people in the public (remember, we code in the open) who want to see our work,
  or learn from our practices
* any future developers (including yourself) who want to see why a change was
  made

Capturing context around a change allows people to understand why a particular
implementation decision was made, much like an [architecture decision record](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions). We're
being kinder to our future selves.

#### Recommended blog posts on commit messages

* [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)
* [5 useful tips for a better commit message](https://thoughtbot.com/blog/5-useful-tips-for-a-better-commit-message)
* [Every line of code is always documented](https://mislav.net/2014/02/hidden-documentation/)

#### Content

A good commit message briefly summarises the "what" for scanning purposes, but
also includes the "why". If the "what" in the message is not enough, the diff is
there as a fallback. This is not true for the "why" of a change - this can be
much harder or impossible to reconstruct, but is often of great significance.

##### Example

``Set cache headers``

prefer:

```
Set cache headers

IE 6 was doing foo, so we need to do X.
See http://example.com/why-is-this-broken for more details.
```

##### Links to issue trackers

A link to a ticket in an issue tracker should not be seen as an alternative to
writing a commit message.

While a link can add some extra context for people reviewing
a pull-request, the commit message should stand on its own. There's no guarantee that
the link will continue to work in the future when someone is looking through the commit
history to understand why a change was made.

If you are adding a link to a publicly viewable repository, ensure that the linked
ticket is publicly viewable (and likely to remain so).

#### Structure

Commit messages should start with a one-line summary no longer than 50
characters. Various Git tools (including GitHub) use this as the commit
summary, so you should format it like an email subject, with a leading capital
and no full stop. The Git convention is to write these in the imperative mood,
as if you are issuing a command to the repository.

For example:

> Leverage best-of-breed synergies going forward

It can help to imagine a silent "please" at the beginning of your message:

> [Please] Leverage best-of-breed synergies going forward

You should leave a blank line before the rest of the commit message, which you
should wrap at around 72 characters: this makes it easier to view commit
messages in a terminal.

##### Example

Taken from [Tim Pope’s guidelines](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).

> Capitalized, short (50 chars or less) summary

> More detailed explanatory text, if necessary.  Wrap it to about 72
characters or so.  In some contexts, the first line is treated as the
subject of an email and the rest of the text as the body.  The blank
line separating the summary from the body is critical (unless you omit
the body entirely); tools like rebase can get confused if you run the
two together.

> Write your commit message in the present tense: "Fix bug" and not "Fixed
bug."  This convention matches up with commit messages generated by
commands like git merge and git revert.

> Further paragraphs come after blank lines.

> - Bullet points are okay, too
> - Typically a hyphen or asterisk is used for the bullet, preceded by a
  single space, with blank lines in between, but conventions vary here
> - Use a hanging indent

## Branching/merging conventions

You should develop on a short-lived "feature" [branch](https://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging) rather than directly on the trunk branch, which is usually `main` or `master`, unless there is a compelling reason to do otherwise.

For example if your repository has many binary files, the `git diff` will not provide useful change information, and you may choose to collaborate directly on the trunk branch.

You should prefer organising your commits as small, self-contained changes rather than having a single commit per pull-request. Ideally, each commit should represent a coherent set of changes and pass all of your project's tests and static analysis.
This will make your changes easier for other people to understand them at review time.

You may need to update your feature branch with the latest changes from the trunk branch when you have multiple people contributing to the same repository.
In this case, you should use [`git rebase`](https://docs.github.com/en/get-started/using-git/about-git-rebase) with the trunk branch name.
This applies your local changes on top of the most recent changes to the trunk branch, rather than creating a merge commit on your feature branch, which keeps the history linear and makes it easier to review.

Git allows you to [rewrite local changes](https://git-scm.com/book/en/Git-Tools-Rewriting-History) by combining commits, splitting commits apart, changing commit messages and many more operations.

You should not rewrite commits that have been merged or pushed to the trunk branch unless there is a compelling reason such as committing personally identifiable information or application secrets.
In this case you should communicate this to affected staff within GDS, so they know to update their local working copy.

You should use `git merge` with `--no-ff` if you are manually merging a feature branch into your repository's trunk branch rather than GitHub's own merge capability.
This option preserves evidence of your feature branch in the repository history by creating a merge commit even if your changes could be simply applied to the trunk branch.

You should use the merge strategy that best suits the context of your team and project.
Rebasing changes onto your trunk branch maintains a linear history but commits are not guaranteed to be in time order.
Merging changes creates a merge commit which is useful as a known integration point for a change but the repository history becomes non-linear.

## Do not use `git push -f`, use `--force-with-lease` instead

Force pushing in git is a subject that attracts all kinds of religious
battles. This advice is not about the merits of force pushing. This is about how
to use `git push -f` if and when you do use it.

Let's say you're working on a branch, 'foobar', and you decide to force push
to the remote. So you do this:

```
$ git push -f
```

If anyone else has committed anything to your branch since you last pulled, you
will blow their changes away.

So for a bit of safety, if you ever need to force push please instead do:

```
$ git push --force-with-lease
```

`--force-with-lease` [refuses to update a
branch](https://blog.developer.atlassian.com/force-with-lease/) unless
it is the state that we expect, which is that nobody has updated the remote branch.

## See also

* [How to store source code](index.html)
* [Working with Git](working-with-git.html)
