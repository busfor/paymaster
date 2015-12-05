module Paymaster
  class GetTransaction
    class Response
    end

    attr_accessor :payment_id
    attr_accessor :paymaster_id

    def endpoint
      "https://api.paymaster.ua/merchants/get-transaction"
    end

    def params
      {
        LMI_MERCHANT_ID: client.merchant_id,
        LMI_PAYMENT_NO: payment_id,
        LMI_SYS_PAYMENT_ID: paymaster_id,
        LMI_HASH: signature,
      }.compact
    end

    def signature

    end

    def perform
      Response.new
    end
  end
end
