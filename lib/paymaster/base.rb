module Paymaster
  class Base
    attr_accessor :client

    def initialize(args={})
      args.each do |k, v|
        public_send "#{k}=", v
      end
    end

    def endpoint
      raise NotImplementedError, 'You should implement #endpoint'
    end

    def params
      {}
    end
  end
end
