module SolidusProductTags
  class Tag < ActiveRecord::Base
    self.table_name = 'solidus_product_tags_tags'
    has_many :product_taggings, dependent: :destroy
    has_many :products, through: :product_taggings, class_name: "Spree::Product"
    validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
    before_validation :normalize_name

private

def normalize_name
  self.name = name.to_s.strip.presence
end
  end
end