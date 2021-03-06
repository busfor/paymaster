module Paymaster
  class UrlGenerator < BaseRequest
    attr_accessor :locale
    attr_accessor :amount
    attr_accessor :number
    attr_accessor :description
    attr_accessor :expires
    attr_accessor :phone_number
    attr_accessor :email
    attr_accessor :success_url
    attr_accessor :success_url_method
    attr_accessor :fail_url
    attr_accessor :fail_url_method
    attr_accessor :payment_system
    attr_accessor :sim_mode

    def endpoint
      "https://lmi.paymaster.ua/#{fetch_locale}/index/get"
    end

    def params
      {
        LMI_MERCHANT_ID: client.merchant_id,
        LMI_PAYMENT_AMOUNT: amount,
        LMI_PAYMENT_NO: number,
        LMI_PAYMENT_DESC: description,
        LMI_EXPIRES: datetime(expires),
        LMI_PAYER_PHONE_NUMBER: phone_number,
        LMI_PAYER_EMAIL: email,
        LMI_SUCCESS_URL: success_url,
        LMI_SUCCESS_METHOD: methods(success_url_method),
        LMI_FAIL_URL: fail_url,
        LMI_FAIL_METHOD: methods(fail_url_method),
        LMI_PAYMENT_SYSTEM: payment_system,
        LMI_SIM_MODE: sim_mode,
        LMI_HASH: signature,
      }.compact
    end

    def generate
      "#{endpoint}?#{params_as_string}"
    end

    def methods(method)
      return unless method
      method.to_s == "post" ? 1 : 0
    end

    def datetime(value)
      return unless value
      value.strftime("%Y-%m-%d %H:%M:%S")
    end

    def signature
      return unless client.secret_key
      string = "#{client.merchant_id}#{number}#{amount}#{client.secret_key}"
      Digest::SHA256.hexdigest(string).upcase
    end

    def params_as_string
      params.map { |k, v| "#{k}=#{v}" }.join("&")
    end

    private

    def fetch_locale
      locale.to_s.in?(%w[ru uk en]) ? locale : "ru"
    end
  end
end
