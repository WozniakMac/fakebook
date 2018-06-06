require 'api/coolpay/api_model'
require 'api/coolpay/connection'

module Api
  module Coolpay
    module Models
      class Recipient < Api::Coolpay::ApiModel
        attr_accessor :id, :name

        URL = '/api/recipients'.freeze

        def self.all(token)
          recipients = APi::Coolpay::Connection.get(URL, {}, token)

          recipients.map do |recipient|
            Recipient.new(recipient)
          end
        end

        def self.find(id, token)
          all(token).find { |recipient| recipient.id == id }
        end

        def save
          APi::Coolpay::Connection.post(URL, { 'name' => name }, @token)
        end
      end
    end
  end
end
