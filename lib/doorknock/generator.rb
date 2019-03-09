# frozen_string_literal: true

require "yaml"
require "uri"

module DoorKnock
  class Generator
    attr_reader :url
    def initialize(url)
      @url = URI(url)
    end

    def base_url
      "#{url.scheme}://#{url.host}:#{url.port}"
    end

    def second_last_url
      parts = url.path.split("/")
      parts.pop if parts.length > 2

      "#{url.scheme}://#{url.host}:#{url.port}" + parts.join("/")
    end

    def admin_panel_urls
      [base_url, second_last_url].uniq.sort.map do |target_url|
        paths.map do |path|
          "#{target_url}/#{path}"
        end
      end.flatten.sort
    end

    def paths
      @paths ||= YAML.safe_load(File.read(File.expand_path("./config/paths.yml", __dir__)))
    end
  end
end
