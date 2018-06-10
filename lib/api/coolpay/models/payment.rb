require 'api/coolpay/api_model'
require 'api/coolpay/models/recipient'
require 'api/coolpay/connection'

module Api
  module Coolpay
    module Models
      class Payment < Api::Coolpay::ApiModel
        attr_accessor :id, :amount, :currency, :recipient_id, :status

        URL = '/api/payments'.freeze

        def self.all(token)
          body, = Api::Coolpay::Connection.get(URL, {}, token)
          payments = body['payments'] || []

          payments.map do |payment|
            Payment.new(token, payment)
          end
        end

        def recipient
          recipient = Api::Coolpay::Models::Recipient.find(recipient_id, @token)
          recipient || Api::Coolpay::Models::Recipient.new(@token)
        end

        def save
          body, = Api::Coolpay::Connection.post(URL, payment_hash, @token)
          find_errors(body)
          body
        end

        private

        def payment_hash
          {
            'payment' => {
              'amount' => amount,
              'currency' => currency,
              'recipient_id' => recipient_id
            }
          }
        end
      end
    end
  end
end
