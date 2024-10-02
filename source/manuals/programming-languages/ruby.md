---
title: Ruby style guide
eleventyNavigation:
  parent: Style guides
last_reviewed_on: 2024-04-23
review_in: 12 months
owner_slack: '#ruby'
permalink: manuals/programming-languages/ruby.html

---

## Code formatting

The GOV.UK programme publishes and maintains a gem, [rubocop-govuk], which
provides linting rules for Ruby projects. These rules extend those described
in [rubystyle.guide]. The rubocop-govuk project has overriden rules to either
match GDS style precedence or to handle scenarios where rules were problematic
to adopt.

[rubocop-govuk] also includes rules for [Rake], [RSpec] and [Ruby on Rails].
The RSpec and Rails rules extend the respective styleguides,
[rspec.rubystyle.guide] and [rails.rubystyle.guide], where only rules that
have proved problematic have been overriden.

## Conventional tooling

GDS uses the [MRI][mri-ruby] implementation of Ruby in projects. You should not
adopt a different one (such as [jRuby]) for projects without clear justification.
The recommended tool for managing multiple Ruby installations is [rbenv].
For dependendency management [bundler] should be used.

For web applications, we advise using [Ruby on Rails] due to
its stability, broad adoption and large community. For smaller web
applications we have chosen [Sinatra] before - however this
should be approached with caution as these can easily become large applications
over time that are less conventionally organised than Rails applications.

## Testing with RSpec

For testing, the [RSpec] framework is the conventional and preferred choice.
RSpec provides an expressive syntax that lends itself to producing readable
tests. For testing functionality from a user's perspective it is preferred
to implement tests in RSpec rather than adopt an abstraction such as [Cucumber],
this is due to us finding it easier to maintain tests where the definition
and implementation are in the same file.

## Further reading

- [GOV.UK documentation on publishing a Ruby gem][govuk-publish-a-ruby-gem]
- [GOV.UK conventions for Rails applications][govuk-rails-conventions]

[rubocop-govuk]: https://github.com/alphagov/rubocop-govuk
[rubystyle.guide]: https://rubystyle.guide
[Ruby on Rails]: https://rubyonrails.org/
[Rake]: https://github.com/ruby/rake
[RSpec]: https://rspec.info/
[rails.rubystyle.guide]: https://rails.rubystyle.guide
[rspec.rubystyle.guide]: https://rspec.rubystyle.guide
[mri-ruby]: https://en.wikipedia.org/wiki/Ruby_MRI
[jRuby]: https://www.jruby.org/
[rbenv]: https://github.com/rbenv/rbenv
[bundler]: https://bundler.io/
[Sinatra]: https://sinatrarb.com/
[Cucumber]: https://github.com/cucumber/cucumber-ruby
[govuk-publish-a-ruby-gem]: https://docs.publishing.service.gov.uk/manual/publishing-a-ruby-gem.html
[govuk-rails-conventions]: https://docs.publishing.service.gov.uk/manual/conventions-for-rails-applications.html
