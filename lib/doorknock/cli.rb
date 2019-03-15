# frozen_string_literal: true

require "thor"

module DoorKnock
  class CLI < Thor
    desc "knock URL", "knock a given URL"
    def knock(url)
      Monitor.knock(url)
    end

    desc "crawl", "crawl & knock phishing websites"
    method_option :size, type: :numeric, default: 100, desc: "Number of urlscan.io's search results to check. (Max: 10,000)"
    def crawl
      size = options.dig(:size) || 100
      Monitor.crawl(size)
    end
  end
end
