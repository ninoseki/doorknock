# frozen_string_literal: true

require "parallel"

module DoorKnock
  class Monitor
    def initialize
      @memo = {}
    end

    def knock(url)
      generator = Generator.new(url)
      generator.admin_panel_urls.each do |panel_url|
        website = Website.new(panel_url)
        next if marked?(website.url)
        next unless website.ok? && website.panel?

        puts [website.url, website.title].join(",")
        mark(website.url)
        break
      end
    end

    def crawl(size = 100)
      Parallel.each(Feed.phishy_urls(size)) do |phishy_url|
        knock phishy_url
      end
    end

    def mark(url)
      @memo[url] = true
    end

    def marked?(url)
      @memo.fetch(url, false)
    end

    def self.crawl(size = 100)
      new.crawl(size)
    end

    def self.knock(url)
      new.knock(url)
    end
  end
end
