require 'test_helper'

module Paymaster
  class UrlGeneratorTest < MiniTest::Test
    def test_it_generates_link
      client = Paymaster::Client.new(merchant_id: 123)
      url = client.generate_url(
        amount: 150,
        number: 123456,
        description: "Test product",
      )

      assert_equal "https://lmi.paymaster.ua/index/get?" \
        "LMI_MERCHANT_ID=123&LMI_PAYMENT_AMOUNT=150&" \
        "LMI_PAYMENT_NO=123456&LMI_PAYMENT_DESC=Test product", url
    end

    def test_it_generates_link_with_all_params
      client = Paymaster::Client.new(merchant_id: 123)
      url = client.generate_url(
        amount: 150,
        number: 123456,
        description: "Test product",
        expires: Time.new(2015, 12, 06, 01, 00),
        phone_number: "+380111222333",
        email: "user@example.com",
        success_url: "http://example.com/success",
        success_url_method: :post,
        fail_url: "http://example.com/fail",
        fail_url_method: :get,
        payment_system: 18,
        sim_mode: 1,
      )

      assert_equal "https://lmi.paymaster.ua/index/get?" \
        "LMI_MERCHANT_ID=123&LMI_PAYMENT_AMOUNT=150&" \
        "LMI_PAYMENT_NO=123456&LMI_PAYMENT_DESC=Test product&" \
        "LMI_EXPIRES=2015-12-06 01:00:00&" \
        "LMI_PAYER_PHONE_NUMBER=+380111222333&" \
        "LMI_PAYER_EMAIL=user@example.com&" \
        "LMI_SUCCESS_URL=http://example.com/success&" \
        "LMI_SUCCESS_METHOD=1&LMI_FAIL_URL=http://example.com/fail&" \
        "LMI_FAIL_METHOD=0&LMI_PAYMENT_SYSTEM=18&LMI_SIM_MODE=1", url
    end

    def test_it_generates_link_with_signature
      client = Paymaster::Client.new(merchant_id: 123, secret_key: 321)
      url = client.generate_url(
        amount: 150,
        number: 123456,
        description: "Test product",
      )

      assert_equal "https://lmi.paymaster.ua/index/get?" \
        "LMI_MERCHANT_ID=123&LMI_PAYMENT_AMOUNT=150&" \
        "LMI_PAYMENT_NO=123456&LMI_PAYMENT_DESC=Test product&" \
        "LMI_HASH=11D3BC18584FFCD22FF8336D9BAEA944386D0EE9813" \
        "F61730D860A57F0E2536C", url
    end
  end
end
