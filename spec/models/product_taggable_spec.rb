# spec/models/product_taggable_spec.rb

require 'spec_helper'

# Dummy model to test the concern
class DummyProduct < ActiveRecord::Base
  self.table_name = "dummy_products"
  include SolidusProductTags::ProductTaggable
end

RSpec.describe SolidusProductTags::ProductTaggable do
  it 'can assign and read tags via tag_list' do
    product = DummyProduct.create!(name: 'Test Product')
    product.tag_list = "Summer, SALE,  new "

    expect(product.tags.map(&:name)).to contain_exactly("summer", "sale", "new")
    expect(product.tag_list).to eq("summer, sale, new")
  end
end

