module Paymaster
  class GetTransaction < BaseRequest
    class Response < BaseResponse
      root "Transaction"

      field :amount, :decimal, key: "LMI_PAYMENT_AMOUNT"
      field :number, :integer, key: "LMI_PAYMENT_NO"
      field :description, key: "LMI_PAYMENT_DESC"
      field :payment_system, :integer, key: "LMI_PAYMENT_SYSTEM"
      field :mode, :integer, key: "LMI_MODE"
      field :paymaster_id, :integer, key: "LMI_SYS_PAYMENT_ID"
      field :payment_date, :datetime, key: "LMI_SYS_PAYMENT_DATE"
      field :paid_amount, :decimal, key: "LMI_PAID_AMOUNT"
      field :payer_identifier, :integer, key: "LMI_PAYER_IDENTIFIER"
      field :payer_phone, key: "LMI_PAYER_PHONE_NUMBER"
      field :payer_email, key: "LMI_PAYER_EMAIL"
      field :merchant_comission, :decimal, key: "LMI_COMMISS_MERCHANT"
      field :payer_comission, :decimal, key: "LMI_COMMISS_PAYER"
      field :bank_id, :integer, key: "BankPaymentId"
      field :state, :integer, key: "State"
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
        LMI_HASH: "",
      }.compact
    end
  end
end
