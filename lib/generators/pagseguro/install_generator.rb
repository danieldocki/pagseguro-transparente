module PagSeguro
  module Generators
    class InstallGenerator < Rails::Generators::Base
      namespace "pagseguro:install"
      source_root File.expand_path("../../templates", __FILE__)

      class_option :use_yml, type: :boolean, default: false, desc: "Use YML file instead of Rails Initializer"

      def generate_config
        if options[:use_yml]
          template "pagseguro.yml", "config/pagseguro.yml"
        end
      end

      def generate_initializer
        unless options[:use_yml]
          template "pagseguro.rb", "config/initializers/pagseguro.rb"
        end
      end
    end
  end
end
