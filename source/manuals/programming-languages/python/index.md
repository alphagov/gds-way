---
title: Python style guide
eleventyNavigation:
  parent: Style guides
last_reviewed_on: 2024-02-14
review_in: 6 months
owner_slack: '#python'
permalink: manuals/programming-languages/python/python.html
---

This manual is designed to aid developers in writing Python code that is clear
and consistent, within, and across, projects at GDS.

## Code formatting

We use [Black][] to format our code. Black is an opinionated formatter that follows
[PEP 8][]; where Black and PEP 8 do not express a view (for example, on the usage of
language features such as metaclasses) we defer to the [Google Python style guide][GPSG].
Use these as references unless something is explicitly mentioned here. These rules
should be followed in conjunction with the advice on consistency on the main
[programming languages manual page][gds-way-code-style-guides].

If you want to add a new rule or exception please create a pull request against this repo.

### Maximum line length of 120 characters

[PEP 8] dictates a preferred maximum line length of <= 79. This is is a hangover from
developing in a Unix terminal window. The vast majority of developers are now using an
IDE which can handle a greater line length.

Couple this with the fact that much of the time GDS developers are coding web apps and
have to deal with nested `JSON` objects, ORM model definitions/ queries, and error/ url
strings and this convention begins to show its age.


## Linting


### Ruff

This manual advises the use of the [Ruff][] command line checker as an all in one lint,
codestyle and complexity checker.

#### How to use Ruff

First you should add the Ruff module (available from [PyPI][]) to your 'dev' or 'test'
requirements/dependencies.

You'll then likely want to run it alongside your unit tests.


#### Ruff ignores

Ruff can ignore particular lines or files.

A particularly useful feature of ruff is the ability to specify rule exemptions
per directory or file.

Commonly it's used for ignoring unused imports in module level `__init__.py`
files or imports not being at the top of a file in settings files or scripts.

The feature is documented in the Ruff documentation, under [per-file-ignores][ruff-ignore-files].
You can also see an example in the [Notifications API repo][Notify-API-pyproject].


#### Common Configuration

Notify is already running the latest verions of [Black][] and [Ruff][] on all
of its repos. You can find an example of their configuration in the root of any
repo in the [`pyproject.toml` file][Notify-API-pyproject].

Commonly a `pyproject.toml` configuration file will live in the root of the package.
It will contain separate sections for each tool the repository needs

```
[tool.black]
line-length = 120

[tool.ruff]
line-length = 120

target-version = "py311"

select = [
    "E",  # pycodestyle
    "W",  # pycodestyle
    "F",  # pyflakes
    "I",  # isort
    "B",  # flake8-bugbear
    "C90",  # mccabe cyclomatic complexity
    "G",  # flake8-logging-format
]
ignore = []
exclude = [
    "migrations/versions/"
]
```

In the above file we exclude directories we want the checker to ignore completely,
include optional linting such as applying isort rules to ensure imports are sorted
for minimal git diffs, set the maximum line length and set the target python version.

Note: you can also ignore rules on particular lines of code or files by adding a `# noqa`
comment - see [ruff's noqa syntax][ruff-error-suppression].

#### Additional linting resources

* [Notify Config][Notify-API-pyproject]: A production config to base off
* [Ruff error codes list][ruff-error-codes-list]

## Environments

This manual advises the use of [Pyenv](https://github.com/pyenv/pyenv) to manage different versions of Python you have installed.
For more information see [Intro to pyenv](https://realpython.com/intro-to-pyenv)

Use the pyev plugin [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) to manage virtual python environment.
For more information see [Python virtual environment primer](https://realpython.com/python-virtual-environments-a-primer/)

[direnv](https://direnv.net/) is used to manage environment variables.
This ensures project specific variables do not clutter your main environment or the environment of other projects.
direnv uses `.envrc` for general project specific variables and you can use a non version controlled `.secrets` to store sensitive information.

## Dependencies

A Python application project typically brings together Python packages from PyPI, with
others written in-house (or otherwise not distributed through PyPI).

These packages are the applications immediate dependencies. Additionally, any
package can have its own immediate dependencies, where they draw on other
packages. From an application's point of view, the dependencies of the packages
it requires are its sub-dependencies.

The below diagram shows a simplified view of the resulting pyramid of dependencies;
however it is important to note that the hierarchy can repeat itself infinitely.

```
                               Application

                                    |
                              +-----+-----+
                              |     |     |

                          Immediate dependencies

                              |     |     |
                        +--+--+--+--+--+--+--+--+
                        |  |  |  |  |  |  |  |  |

                         ... Sub-dependencies ...
```

There are two ways of specifying dependencies in Python world: as a specific version or
as an allowable range.

Different considerations apply to dependency management depending whether you are packaging a library, or creating
an end-product such as an application or a bundle of scripts. In general, you should only specify specific versions
when creating a Python system that sits at the top of the dependency pyramid; otherwise there is a danger of creating
version conflicts.

### Applications

These recommendations apply wherever you need a reproducible set of dependencies, such
as a complete web application, perhaps with many dependencies and sub-dependencies. It also
applies to a collection of scripts that are deployed into the cloud and run automatically
(for example, batch jobs).

A good strategy for specifying your application's Python dependencies has two desirable
characteristics - they should be:

1. Reproducible (predictable)

    Pin your application's full dependencies – specific versions, rather than ranges – or you'll
    get unpredictability between your dev environment and other environments. You want a
    new starter to avoid small hard-to-spot problems. And you want parity between what you
    test locally, what is tested by CI, and what you deploy, or you risk new issues appearing on
    a live server. Additionally these things can be hard to diagnose.

2. Kept up-to-date

    Security issues are found in libraries, so it is important to choose libraries that are
    maintained and to ensure your team has a strategy to ensure security updates are installed
    without significant delay. The [how to manage third party software dependencies][gds-way-deps] section
    gives further context and discusses tools that can help, such as [snyk.io][].

Your README should document an easy-to-follow process by which all your Python
dependencies can be upgraded to get bug fixes and security fixes, without introducing
breaking changes to your build.

Your pinned dependencies should be fully specified in a file called `requirements.txt`, and checked
into your version control system (VCS). For projects with only a small number of dependencies, maintaining
this manually (for example, installing with `pip install`, then using `pip freeze`) may be adequate.

For larger projects, GDS recommends using [pip-tools][pip-tools] for managing dependencies.

Put your top-level requirements in a `requirements.in` file, and then use `pip-compile` to generate a
`requirements.txt` file. Both the .in and .txt files should be commited to your repository.

List dependencies only needed for development or testing into a separate `requirements-dev.txt` file.

### Libraries

This recommendation applies to any Python repository that intended to be installable (into
a virtual environment, a container, or onto bare metal) as a dependency of some larger system
or application. It may be applicable to repositories that provide scripts to be run by
developers or other end-users, but is not recommended for code that's intended to be deployed
on its own into the cloud.

Use a [`setup.py`][setup-deps]
to specify the dependencies of your library, and the version ranges with which it
can be reasonably expected to work.

- The range you choose will depend on the guarantees each dependency makes about
  backward-compatibility. For example, if you're currently using version 1.3.1 of
  a semantically-versioned library, it would be reasonable to specify a range such
  as `<2.0,>=1.3.1`. However, for a library that does not make that guarantee,
  you might specify a more restricted range, such as `<1.4,>=1.3.1`.

- Update this file whenever you are ready to test and validate a new version that falls
  outside the existing range.

> If you have dependencies that are not available on PyPI (for example, because you've fixed
> a bug by forking the code), then you can use a [PEP 440][]
> git reference in your `install_requires` list.
>
> - In the past, we've documented such dependencies in a `requirements.txt` file
> ([example](https://github.com/alphagov/digitalmarketplace-utils/commit/dc16012af6b55d9eda4e8dd7fee514103682a5c7#diff-4d7c51b1efe9043e44439a949dfd92e5827321b34082903477fd04876edb7552)),
> but any application wanting to depend on your library then needs to manually copy those sub-dependencies into its
> own list
> ([example](https://github.com/alphagov/digitalmarketplace-briefs-frontend/commit/5fb3df85bf9fa109ba3eaf1750a4fba4e92ef2a8#diff-4d7c51b1efe9043e44439a949dfd92e5827321b34082903477fd04876edb7552)).

Specify dependencies needed only for testing your library in `tox.ini` if you are using [Tox](https://tox.readthedocs.io/en/latest/)
([example](https://github.com/alphagov/notifications-python-client/blob/f27b67a53371c68c36583f985c29b0526e2294b9/tox.ini)),
or in a `requirements-dev.txt` ([example](https://github.com/alphagov/digitalmarketplace-utils/blob/222e50c022eae4d9b2569b148cdfc642b08733cf/requirements-dev.txt))
file otherwise.

[PyPI]: https://pypi.org/
[gds-way-deps]: /standards/tracking-dependencies.html
[gds-way-code-style-guides]: /manuals/programming-languages.html
[slack-python]: https://gds.slack.com/messages/python
[GPSG]: https://google.github.io/styleguide/pyguide.html

[snyk.io]: https://snyk.io/
[setup-deps]: https://docs.python.org/3.11/distutils/setupscript.html#relationships-between-distributions-and-packages
[pip-tools]: https://pip-tools.readthedocs.io/en/stable/

[Black]: https://black.readthedocs.io/en/stable/
[PEP 8]: https://www.python.org/dev/peps/pep-0008/
[PEP 440]: https://www.python.org/dev/peps/pep-0440/#direct-references

[ruff]: https://docs.astral.sh/ruff
[ruff-ignore-files]: https://docs.astral.sh/ruff/settings/#lint_per-file-ignores
[ruff-error-suppression]: https://docs.astral.sh/ruff/linter/#error-suppression
[ruff-error-codes-list]: https://docs.astral.sh/ruff/rules/
[Notify-api-pyproject]: https://github.com/alphagov/notifications-api/blob/0f4f6ce1e4f3fb22731ca426e8a17a2b154e3f8f/pyproject.toml
