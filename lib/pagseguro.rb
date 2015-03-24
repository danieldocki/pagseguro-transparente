require "active_model"
require "config"
require "pagseguro/version"
require "pagseguro/request"
require "pagseguro/session"
require "pagseguro/session/response"
require "pagseguro/item"
require "pagseguro/items"
require "pagseguro/payment"
require "pagseguro/payment/serializer"
require "pagseguro/transaction"
require "pagseguro/transaction/address"
require "pagseguro/transaction/item"
require "pagseguro/transaction/items"
require "pagseguro/transaction/payment_method"
require "pagseguro/transaction/phone"
require "pagseguro/transaction/sender"
require "pagseguro/transaction/shipping"
require "pagseguro/transaction/creditor_fees"
require "pagseguro/notification"
require "pagseguro/query"
require "pagseguro/sender"
require "pagseguro/phone"
require "pagseguro/document"
require "pagseguro/bank"
require "pagseguro/credit_card"
require "pagseguro/holder"
require "pagseguro/address"
require "pagseguro/shipping"
require "pagseguro/installment"
require "pagseguro/refund"

I18n.enforce_available_locales = false
I18n.load_path += Dir[File.expand_path('../../config/locales/*.yml',  __FILE__)]

module PagSeguro
  class << self
    def config=(data)
      @config = data
    end

    def config
      @config ||= Config.new
    end

    def configure(&block)
      yield config
    end

    def adapter_javascript_url
      config.adapter_javascript_url
    end

    def api_url(version)
      uris.fetch(config.environment) + version
    end

    private
    def uris
      @uris ||= {
        production: 'https://ws.pagseguro.uol.com.br/',
        sandbox: 'https://ws.sandbox.pagseguro.uol.com.br/'
      }
    end
  end

  self.config.environment = :production

  # Set the global configuration.
  #
  #   PagSeguro.configure do |config|
  #     config.email = "john@example.com"
  #     config.token = "abc"
  #     config.environment = :sandbox
  #   end
end
