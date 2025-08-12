class AddUniqueIndexToProductTaggings < ActiveRecord::Migration[8.0]
  def change
    add_index :solidus_product_tags_product_taggings, [:product_id, :tag_id], unique: true, name: 'idx_product_taggings_on_product_id_and_tag_id'
  end
end
