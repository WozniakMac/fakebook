require 'faraday'

module Api
  module Coolpay
    class Connection
      BASE_URL = 'https://private-anon-32a3a8c694-coolpayapi.apiary-mock.com/api'.freeze

      def self.api(token = nil)
        Faraday.new(url: BASE_URL) do |faraday|
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
          faraday.headers['Content-Type'] = 'application/json'
          faraday.headers['Authorization'] = token if token.present?
        end
      end

      def self.get(path, query = {}, token = nil)
        response = api(token).get(path, query)
        [JSON.parse(response.body), response.status]
      end

      def self.post(path, body = {}, token = nil)
        response = api(token).post do |req|
          req.url path
          req.body = body
        end
        [JSON.parse(response.body), response.status]
      end
    end
  end
end
