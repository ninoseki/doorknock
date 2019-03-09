# frozen_string_literal: true

require "parallel"

module DoorKnock
  class Monitor
    def initialize
      @memo = {}
    end

    def check(size = 100)
      Parallel.each(Feed.phishy_urls(size)) do |phishy_url|
        generator = Generator.new phishy_url
        generator.admin_panel_urls.each do |panel_url|
          website = Website.new(panel_url)
          next if marked?(website.url)
          next unless website.ok? && website.panel?

          puts [website.url, website.title].join(",")
          mark(website.url)
          break
        end
      end
    end

    def mark(url)
      @memo[url] = true
    end

    def marked?(url)
      @memo.fetch(url, false)
    end

    def self.check(size = 100)
      new.check(size)
    end
  end
end
