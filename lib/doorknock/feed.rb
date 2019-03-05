# frozen_string_literal: true

require "http"
require "json"
require "uri"

module DoorKnock
  class Feed
    URLSCAN_ENDPOINT = "https://urlscan.io/api/v1/search/"
    URLSCAN_QUERY = "PhishTank OR OpenPhish OR CertStream-Suspicious"

    def phishy_urls(size = 100)
      res = HTTP.get(
        URLSCAN_ENDPOINT,
        params: {
          q: URLSCAN_QUERY,
          size: size
        }
      )
      return [] if res.code != 200

      json = JSON.parse(res.body.to_s)
      results = json["results"]
      results.map { |result| result.dig("page", "url") }.compact.uniq.map do |url|
        url.end_with?("/") ? url[0..-2] : url
      end
    end

    def self.phishy_urls(size = 100)
      new.phishy_urls(size)
    end
  end
end
