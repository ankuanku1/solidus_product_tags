module SolidusProductTags
  class Tag < ActiveRecord::Base
    self.table_name = 'solidus_product_tags_tags'
    has_many :product_taggings, dependent: :destroy
    has_many :products, through: :product_taggings, class_name: "Spree::Product"
    validates :name, presence: true, uniqueness: true
  end
end
