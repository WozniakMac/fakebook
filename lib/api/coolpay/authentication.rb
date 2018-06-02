require 'api/coolpay/connection'
require 'json'

module Api
  module Coolpay
    class Authentication
      def self.login(username, apikey)
        body, status = Api::Coolpay::Connection.api.post(
          '/login',
          'username' => username,
          'apikey' => apikey
        )

        return body if status == 200
        { 'error' => 'Unsuccessful login' }
      end
    end
  end
end
