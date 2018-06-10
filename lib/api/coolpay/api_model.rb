module Api
  module Coolpay
    class ApiModel
      attr_accessor :token
      attr_reader :errors

      def initialize(token, args = {})
        @token = token
        @errors = []

        find_errors(args)

        args.each do |name, value|
          attr_name = name.to_s.underscore
          send("#{attr_name}=", value) if respond_to?("#{attr_name}=")
        end
      end

      private

      def find_errors(args)
        @errors << args['error'] if args['error'].present?
      end
    end
  end
end
