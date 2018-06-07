module Api
  module Coolpay
    class ApiModel
      attr_accessor :errors, :token

      def initialize(token, args = {})
        @token = token
        @errors = []

        args.each do |name, value|
          attr_name = name.to_s.underscore
          send("#{attr_name}=", value) if respond_to?("#{attr_name}=")
        end
      end
    end
  end
end
