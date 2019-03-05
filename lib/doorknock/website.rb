# frozen_string_literal: true

require "http"
require "oga"

module DoorKnock
  class Website
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def body
      @body ||= get_body
    end

    def ok?
      !body.nil?
    end

    def panel?
      password_form?
    end

    def password_form?
      form = doc&.at_css("form")
      form && !form.at_css("input[type='password']").nil?
    end

    def title
      doc&.at_css("title")&.text
    end

    def doc
      @doc ||= [].tap do |out|
        next unless body

        begin
          out << Oga.parse_html(body)
        rescue LL::ParserError => _
          nil
        end
      end.first
    end

    private

    def get_body
      res = HTTP.timeout(3).get(url)
      return nil if res.code != 200

      res.body.to_s
    rescue HTTP::Error, OpenSSL::SSL::SSLError, Addressable::URI::InvalidURIError => _
      nil
    end
  end
end
