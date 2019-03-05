# frozen_string_literal: true

require "yaml"
require "uri"

module DoorKnock
  class Generator
    attr_reader :urls
    def initialize(urls = [])
      @urls = urls.map do |url|
        URI(url)
      end.compact
    end

    def base_urls
      urls.map do |url|
        "#{url.scheme}://#{url.host}:#{url.port}"
      end
    end

    def second_last_urls
      urls.map do |url|
        parts = url.path.split("/")
        parts.pop if parts.length > 2

        "#{url.scheme}://#{url.host}:#{url.port}" + parts.join("/")
      end
    end

    def admin_panel_urls
      (base_urls + second_last_urls).uniq.sort.map do |url|
        paths.map do |path|
          "#{url}/#{path}"
        end
      end.flatten.sort
    end

    def paths
      @paths ||= YAML.safe_load(File.read(File.expand_path("./config/paths.yml", __dir__)))
    end
  end
end
