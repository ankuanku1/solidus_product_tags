
module SolidusProductTags
  class Engine < Rails::Engine
    engine_name "solidus_product_tags"
    isolate_namespace SolidusProductTags

    initializer "solidus_product_tags.load_product_taggable" do
      config.to_prepare do
        ::Spree::Product.include SolidusProductTags::ProductTaggable
      end
    end

    initializer "solidus_product_tags.decorate_solidus_admin_components" do
      config.after_initialize do
        ActiveSupport.on_load(:after_initialize) do
          begin
            require "solidus_product_tags/admin/product_form_component_decorator"
            SolidusAdmin::Products::FormComponent.prepend(
              SolidusProductTags::Admin::ProductFormComponentDecorator
            )
          rescue NameError => e
            Rails.logger.warn("[solidus_product_tags] Could not decorate SolidusAdmin component: #{e.message}")
          end
        end
      end
    end
  end
end
