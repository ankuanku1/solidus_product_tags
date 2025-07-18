module SolidusProductTags
  class ProductTagging < ActiveRecord::Base
    belongs_to :product, class_name: "Spree::Product"
    belongs_to :tag, class_name: "SolidusProductTags::Tag"
  end
end
