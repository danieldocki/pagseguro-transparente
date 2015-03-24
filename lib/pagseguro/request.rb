require 'httparty'

module PagSeguro
  class Request
    include HTTParty
    debug_output $stderr
    API_VERSIONS = [API_V2 = 'v2', API_V3 = 'v3']

    def get(path, version, account = "default")
      self.class.base_uri PagSeguro.api_url(version)
      options = { query: add_credencials(account) }
      self.class.get(path, options)
    end

    def post(path, version, account = "default", params = {})
      self.class.base_uri PagSeguro.api_url(version)
      options = { body: add_credencials(account) }
      options[:body].merge!(params)
      options[:timeout] = PagSeguro.config.timeout unless PagSeguro.config.timeout.blank?
      self.class.post(path, options)
    end

    private
    def add_credencials(account)
      if account == "alternative"
         { email: PagSeguro.config.alt_email, token: PagSeguro.config.alt_token }
      else
         { email: PagSeguro.config.email, token: PagSeguro.config.token }
      end
    end
  end
end
