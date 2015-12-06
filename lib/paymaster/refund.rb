module Paymaster
  class Refund < BaseRequest
    class Response < BaseResponse
      field :code, :integer, key: "ResultCode"
      field :message, key: "ResultMsg"
    end

    attr_accessor :paymaster_id
    attr_accessor :refund_id
    attr_accessor :total
    attr_accessor :refund_amount

    def endpoint
      "https://api.paymaster.ua/merchants/refund"
    end

    def params
      {
        LMI_MERCHANT_ID: client.merchant_id,
        LMI_SYS_PAYMENT_NO: paymaster_id,
        RefundId: refund_id,
        ActionAmount: total,
        RefundAmount: refund_amount,
        LMI_HASH: "",
      }.compact
    end
  end
end
