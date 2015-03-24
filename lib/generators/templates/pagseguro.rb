PagSeguro.configure do |config|
  config.environment            = :sandbox
  config.adapter_javascript_url = "https://stc.sandbox.pagseguro.uol.com.br/pagseguro/api/v2/checkout/pagseguro.directpayment.js"
  config.email                  = "exemplo@pagseguro.com.br"
  config.token                  = "token válido"
end
