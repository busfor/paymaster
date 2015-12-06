module Paymaster
  class BaseRequest
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

    def sign(string)
      return unless client.secret_key
      Digest::SHA256.hexdigest(string + client.secret_key)
    end

    def perform
      xml_body = params.to_xml(
        root: "Command",
        skip_types: true,
        skip_instruct: true,
        indent: 0,
        dasherize: false,
      )
      signature = sign(xml_body)
      xml_body.gsub! "<LMI_HASH></LMI_HASH>", "<LMI_HASH>#{signature}</LMI_HASH>"
      response = Faraday.post endpoint, xml_body

      self.class::Response.parse(response.body)
    end
  end
end
