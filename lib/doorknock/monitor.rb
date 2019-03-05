# frozen_string_literal: true

module DoorKnock
  class Monitor
    def initialize
      @memo = {}
    end

    def check(size = 100)
      phishy_urls = Feed.phishy_urls(size)
      generator = Generator.new(phishy_urls)

      generator.admin_panel_urls.map do |url|
        Website.new url
      end.each do |website|
        next unless website.ok? && website.panel?

        puts [
          website.url,
          website.title
        ].join(",")

        break
      end
    end

    def self.check(size = 100)
      new.check(size)
    end
  end
end
