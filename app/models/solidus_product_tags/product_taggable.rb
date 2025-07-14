module SolidusProductTags
  module ProductTaggable
    extend ActiveSupport::Concern

    included do
      has_many :product_taggings,
               class_name: "SolidusProductTags::ProductTagging",
               foreign_key: :product_id,
               dependent: :destroy

      has_many :tags,
               through: :product_taggings,
               class_name: "SolidusProductTags::Tag"
    end

    def tag_list
      tags.map(&:name).join(", ")
    end

    def tag_list=(names)
      self.tags = names.split(",").map do |name|
        SolidusProductTags::Tag.find_or_create_by(name: name.strip.downcase)
      end
    end
  end
end
