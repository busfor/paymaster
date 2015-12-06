module Paymaster
  class RequestError
    attr_accessor :data
    attr_accessor :error_code
    attr_accessor :error_message

    def initialize(response)
      self.data = response
      self.error_code = response["Retval"].to_i
      self.error_message = response["Retdesc"]
    end

    def error?
      true
    end
  end
end
