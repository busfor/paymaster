module Paymaster
  class BaseResponse
    attr_accessor :data

    def initialize(args={})
      args.each do |k, v|
        public_send "#{k}=", v
      end
    end

    def error?
      false
    end

    class << self
      def parse(body)
        response = Hash.from_xml(body)["Response"]

        if response["Retval"].to_i != 1
          Paymaster::RequestError.new(response)
        else
          response = response["Retdata"]
          response = response[root] if root
          attrs = {}

          response.each do |key, value|
            next unless field = fields[key]
            attrs[field[:name]] = send(field[:type], value)
          end

          new(attrs.merge(data: response))
        end
      end

      protected

      def root(value=nil)
        @root ||= value
      end

      def fields
        @fields ||= {}
      end

      def field(name, type=:string, key: name.to_s)
        fields[key] = { name: name, type: type }
        attr_accessor name
      end

      def decimal(value)
        BigDecimal.new(value)
      end

      def integer(value)
        value.to_i
      end

      def string(value)
        value
      end

      def datetime(value)
        ActiveSupport::TimeZone["Europe/Kiev"].parse(value)
      end
    end
  end
end
