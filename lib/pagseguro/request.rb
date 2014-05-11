require 'httparty'

module PagSeguro
  class Request
    include HTTParty
    debug_output $stderr

    base_uri "https://ws.pagseguro.uol.com.br/v2/"

    def get(path, email, token, params = {})
      options = add_credencials(email, token, params)
      self.class.get(path, options)
    end

    def post(path, email, token, params = {})
      options = add_credencials(email, token, params)

      response = self.class.post(path, options)
      response.parsed_response
    end

    private
    def add_credencials(email, token, params)
      #puts "email: #{email}"
      #puts "token: #{token}"
      options = { body:
        {
          email: email || PagSeguro.email,
          token: token || PagSeguro.token
        }
      }
      options[:body].merge!(params)
      #puts "options #{options}"
      options
    end
  end
end
