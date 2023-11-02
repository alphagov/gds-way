require 'govuk_tech_docs'

# Check for broken links
require 'html-proofer'

GovukTechDocs.configure(self)

set :layout, 'custom'

after_build do |builder|
  begin
    # Newly created files on feature branches do not yet exist in production, so tell HTML Proofer to ignore links to them
    # Based on https://github.com/gjtorikian/html-proofer#ignoring-new-files
    merge_base = `git merge-base origin/main HEAD`
    new_urls = %x(git diff -z --name-only --diff-filter=AC #{merge_base})
      .split("\0")
      .filter { |path| path.start_with? "source/" }
      .map { |path| path.delete_prefix("source/").delete_suffix(".erb").delete_suffix(".md") }
      .map { |path| "https://gds-way.cloudapps.digital/#{path}" }

    proofer = HTMLProofer.check_directory(config[:build_dir],
      { :assume_extension => true,
        :allow_hash_href => true,
        :check_internal_hash => true,
        :empty_alt_ignore => true,
        :file_ignore => [
            /search/ # Provided by tech-docs gem but has a "broken" link from html-proofer's point of view
        ],
        :url_ignore => [
            "https://gdshelpdesk.digital.cabinet-office.gov.uk",
            "https://gds-way.cloudapps.digital/standards/secrets-acl.html",
            /https:\/\/github.com\//
        ].concat(new_urls)
      })

      proofer.run
  rescue RuntimeError => e
    abort e.to_s
  end
end