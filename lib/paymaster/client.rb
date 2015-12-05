module Paymaster
  class Client
    attr_accessor :merchant_id
    attr_accessor :secret_key

    def initialize(merchant_id:, secret_key: nil)
      self.merchant_id = merchant_id
      self.secret_key = secret_key
    end

    def generate_url(args)
      UrlGenerator.new(args.merge(client: self)).generate
    end

    def get_transaction(args)
      GetTransaction.new(args.merge(client: self)).perform
    end

    def refund(args)
      Refund.new(args.merge(client: self)).perform
    end
  end
end
