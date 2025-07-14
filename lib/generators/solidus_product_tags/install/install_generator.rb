require 'rails/generators/base'

module SolidusProductTags
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def copy_migrations
        rake "railties:install:migrations FROM=solidus_product_tags"
      end

      def run_migrations
        rake "db:migrate"
      end
    end
  end
end
