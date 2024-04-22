require 'html-proofer'

begin
  # Newly created files on feature branches do not yet exist in production, so tell HTML Proofer to ignore links to them
  # Based on https://github.com/gjtorikian/html-proofer#ignoring-new-files
  merge_base = `git merge-base origin/main HEAD`
  new_urls = %x(git diff -z --name-only --diff-filter=AC #{merge_base})
    .split("\0")
    .filter { |path| path.start_with? "source/" }
    .map { |path| path.delete_prefix("source/").delete_suffix(".erb").delete_suffix(".md") }

  proofer = HTMLProofer.check_directory(
    "build",
    {
      :assume_extension => true,
      :allow_hash_href => true,
      :check_internal_hash => true,
      :ignore_files => [
          /search/ # Provided by tech-docs gem but has a "broken" link from html-proofer's point of view
      ],
      :ignore_urls => [
          "https://gdshelpdesk.digital.cabinet-office.gov.uk",
          /https:\/\/github.com\//
      ].concat(new_urls)
    }
  )

  proofer.run
rescue RuntimeError => e
  abort e.to_s
end
