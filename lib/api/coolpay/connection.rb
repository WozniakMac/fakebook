require 'faraday'
require 'faraday_middleware'
require 'faraday/conductivity'
require 'json'

module Api
  module Coolpay
    class Connection
      BASE_URL = 'https://private-anon-32a3a8c694-coolpayapi.apiary-mock.com/'.freeze

      def self.api(token = nil)
        Faraday.new(url: BASE_URL) do |faraday|
          faraday.request :json
          faraday.response :json
          faraday.headers['Content-Type'] = 'application/json'
          faraday.headers['Authorization'] = token if token.present?
          faraday.use :extended_logging
          faraday.adapter Faraday.default_adapter
        end
      end

      def self.get(path, query = {}, token = nil)
        response = api(token).get(path, query)

        [parse_body(response.body), response.status]
      rescue Faraday::ParsingError
        [{ 'error' => 'Invalid response' }, 404]
      end

      def self.post(path, body = {}, token = nil)
        response = api(token).post do |req|
          req.url path
          req.body = body
        end

        [parse_body(response.body), response.status]
      rescue Faraday::ParsingError => e
        puts e
        [{ 'error' => 'Invalid response' }, 404]
      end

      def self.parse_body(body)
        if body.is_a?(Hash)
          body
        else
          { 'error' => body }
        end
      end

      private_class_method :parse_body
    end
  end
end
