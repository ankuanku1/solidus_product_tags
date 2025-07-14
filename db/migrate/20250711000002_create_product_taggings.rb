class CreateProductTaggings < ActiveRecord::Migration[8.0]
  def change
    create_table :solidus_product_tags_product_taggings do |t|
      t.references :product, null: false, foreign_key: { to_table: :spree_products }
      t.references :tag, null: false, foreign_key: { to_table: :solidus_product_tags_tags }
      t.timestamps
    end
  end
end
