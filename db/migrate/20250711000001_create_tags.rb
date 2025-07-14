class CreateTags < ActiveRecord::Migration[8.0]
  def change
    create_table :solidus_product_tags_tags do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :solidus_product_tags_tags, :name, unique: true
  end
end
