module Paymaster
  class Refund < Base
    class Response

    end

    def initialize(args)
      super

      self.options = args
    end

    def perform
      Response.new
    end
  end
end
