# frozen_string_literal: true

require "thor"

module DoorKnock
  class CLI < Thor
    desc "knock", "knock phishing websites"
    method_option :size, type: :numeric, default: 100, desc: "Number of urlscan.io's search results to check. (Max: 10,000)"
    def knock
      size = options.dig(:size) || 100
      Monitor.check(size)
    end
  end
end
