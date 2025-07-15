
module SolidusProductTags
  class Engine < Rails::Engine
    engine_name "solidus_product_tags"
    isolate_namespace SolidusProductTags

    initializer "solidus_product_tags.load_product_taggable" do
      config.to_prepare do
        ::Spree::Product.include SolidusProductTags::ProductTaggable
      end
    end
  end
end
