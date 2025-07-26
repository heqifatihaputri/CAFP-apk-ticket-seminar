module UrlChecker
  extend ActiveSupport::Concern

  included do
    require 'uri'

    def self.uri?(string)
      uri = URI.parse(string)
      %w( http https ).include?(uri.scheme)
    rescue URI::BadURIError
      false
    rescue URI::InvalidURIError
      false
    end
  end
end