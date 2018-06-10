require 'api/coolpay/api_model'
require 'api/coolpay/connection'

module Api
  module Coolpay
    module Models
      class Recipient < Api::Coolpay::ApiModel
        attr_accessor :id, :name

        URL = '/api/recipients'.freeze

        def self.all(token)
          body, = Api::Coolpay::Connection.get(URL, {}, token)
          recipients = body['recipients'] || []

          recipients.map do |recipient|
            Recipient.new(token, recipient)
          end
        end

        def self.find(id, token)
          all(token).find { |recipient| recipient.id == id }
        end

        def save
          body, = Api::Coolpay::Connection.post(URL, { 'recipient' => { 'name' => name } }, @token)
          find_errors(body)
          body
        end
      end
    end
  end
end
