module PagSeguro
  class Config
    # Primary e-mail associated with the primary account.
    attr_accessor :email

    # The API token associated with primary account.
    attr_accessor :token

    # Sencondary e-mail associated with secondary account.
    attr_accessor :alt_email

    # The API token associated with secondary account.
    attr_accessor :alt_token

    # The PagSeguro environment.
    # Only +production+ for now.
    attr_accessor :environment

    # Timeout value in seconds for requests.
    attr_accessor :timeout

    # Javascript adapter
    attr_accessor :adapter_javascript_url

    def initialize
      load_yml! if defined?(Rails) && yml_exists?
    end

    def yml_exists?
      defined?(Rails.root) ? File.exist?(self.yml_path) : false
    end

    def yml
      begin
        @yml ||= HashWithIndifferentAccess.new(YAML.load_file(yml_path)[Rails.env]) rescue nil || {}
      rescue Psych::SyntaxError
        @yml = {}
      end
    end

    def yml_path
      Rails.root.join("config/pagseguro.yml")
    end

    def load_yml!
      self.email                  = yml[:email]
      self.token                  = yml[:token]
      self.alt_email              = yml[:alt_email]
      self.alt_token              = yml[:alt_token]
      self.timeout                = yml[:timeout]
      self.adapter_javascript_url = yml[:adapter_javascript_url]
      self.environment            = yml[:environment].to_sym
    end
  end
end
