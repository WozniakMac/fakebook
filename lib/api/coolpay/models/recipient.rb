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
          recipients = body['recipients'] || [] if body.is_a?(Hash)
          recipients = [] if body.is_a?(String)

          recipients.map do |recipient|
            Recipient.new(token, recipient)
          end
        end

        def save
          Api::Coolpay::Connection.post(URL, { 'recipient' => { 'name' => name } }, @token)
        end
      end
    end
  end
end
