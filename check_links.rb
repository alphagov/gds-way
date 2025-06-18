require 'html-proofer'

begin
  # Newly created files on feature branches do not yet exist in production, so tell HTML Proofer to ignore links to them
  # Based on https://github.com/gjtorikian/html-proofer#ignoring-new-files
  merge_base = `git merge-base origin/main HEAD`
  new_urls = %x(git diff -z --name-only --diff-filter=AC #{merge_base})
    .split("\0")
    .filter { |path| path.start_with? "source/" }
    .map { |path| path.delete_prefix("source/").delete_suffix(".erb").delete_suffix(".md") }

  individual_exceptions = [
    "https://www.cloudflare.com/en-gb/learning/dns/dnssec/how-dnssec-works/",
    "https://docs.google.com/presentation/d/1LHLKPclfrn5KVFrFd2WqyPOYpS6wXklE4Lexb2rJNW0/",
    "https://dzone.com/articles/optional-ispresent-is-bad-for-you",
    "https://dzone.com/articles/using-optional-correctly-is-not-optional",
    "https://go.dev/talks/2012/10things.slide#11",
    "https://securityheaders.com",
    "https://stackoverflow.com/questions/26327957/should-java-8-getters-return-optional-type/26328555#26328555",\
    "https://www.cloudflare.com/en-gb/learning/dns/dnssec/how-dnssec-works/",
    "https://www.etsy.com/codeascraft/blameless-postmortems/",
    "https://www.sciencedirect.com/science/article/abs/pii/S0950584909000123",
    "https://www.ncsc.gov.uk/guidance/introduction-identity-and-access-management#section_6",
    "https://www.sciencedirect.com/science/article/abs/pii/S0950584909000123",
    "https://intranet.cabinetoffice.gov.uk/it-data-and-security/cyber-and-information-security-services/",
    "https://intranet.cabinetoffice.gov.uk/it-data-and-security/cyber-and-information-security-services/threat-modelling/",
  ]

  proofer = HTMLProofer.check_directory(
    "build",
    {
      typhoeus: {
        headers: { "User-Agent" => "Mozilla/5.0 (Android 14; Mobile; LG-M255; rv:122.0) Gecko/122.0 Firefox/122.0" }
      },
      :assume_extension => true,
      :allow_hash_href => true,
      :check_internal_hash => true,
      :ignore_files => [
          /search/ # Provided by tech-docs gem but has a "broken" link from html-proofer's point of view
      ],
      :ignore_urls => [
        %r{https://gds.splunkcloud.com},
        %r{https://gdshelpdesk.digital.cabinet-office.gov.uk/},
        %r{https://github.com/},
        %r{https://www.cnvc.org/},
        %r{https://securityheaders.com/},
        %r{https://www.webpagetest.org/},
        %r{https://www.pingdom.com/}
    ].concat(individual_exceptions)
     .concat(new_urls)
    }
  )

  proofer.run
rescue RuntimeError => e
  abort e.to_s
end

