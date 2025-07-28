# spec/models/product_taggable_spec.rb

require 'spec_helper'

# Dummy model to test the concern
class DummyProduct < ActiveRecord::Base
  self.table_name = "dummy_products"
  include SolidusProductTags::ProductTaggable
end

RSpec.describe SolidusProductTags::ProductTaggable do
  before(:each) do
    DummyProduct.delete_all
    SolidusProductTags::Tag.delete_all
    SolidusProductTags::ProductTagging.delete_all
  end

  it 'can assign and read tags via tag_list' do
    product = DummyProduct.create!(name: 'Test Product')
    product.tag_list = "Summer, SALE,  new "

    expect(product.tags.map(&:name)).to contain_exactly("summer", "sale", "new")
    expect(product.tag_list).to eq("summer, sale, new")
  end

  it 'handles empty tag_list assignment' do
    product = DummyProduct.create!(name: 'Test Product')
    product.tag_list = ""
    expect(product.tags).to be_empty
    expect(product.tag_list).to eq("")
  end

  it 'removes duplicate tags and strips whitespace' do
    product = DummyProduct.create!(name: 'Test Product')
    product.tag_list = "  Summer , summer ,  SUMMER "
    expect(product.tags.map(&:name)).to eq(["summer"])
    expect(product.tag_list).to eq("summer")
  end

  it 'updates tags when tag_list is changed' do
    product = DummyProduct.create!(name: 'Test Product')
    product.tag_list = "summer, sale"
    product.save!

    product.tag_list = "new, sale"
    product.save!

    expect(product.tags.map(&:name)).to match_array(["new", "sale"])
  end

  it 'persists assigned tags' do
    product = DummyProduct.create!(name: 'Test Product')
    product.tag_list = "summer, sale"
    product.save!

    reloaded = DummyProduct.find(product.id)
    expect(reloaded.tag_list).to eq("summer, sale")
  end

  it 'reuses existing tags instead of duplicating them' do
    existing = SolidusProductTags::Tag.create!(name: 'summer')
    product = DummyProduct.create!(name: 'Test Product')
    product.tag_list = "summer"
    product.save!

    expect(SolidusProductTags::Tag.where(name: 'summer').count).to eq(1)
    expect(product.tags.first).to eq(existing)
  end

  it 'removes old taggings when tags are removed from tag_list' do
    product = DummyProduct.create!(name: 'Test Product')
    product.tag_list = "summer, sale"
    product.save!

    product.tag_list = "sale"
    product.save!

    expect(product.tags.map(&:name)).to eq(["sale"])
  end

  it 'ignores nil or blank items in tag_list' do
    product = DummyProduct.create!(name: 'Test Product')
    product.tag_list = "summer, ,  , sale"
    expect(product.tags.map(&:name)).to eq(["summer", "sale"])
  end

  it 'destroys associated product_taggings when the product is destroyed' do
    product = DummyProduct.create!(name: 'Test Product')
    product.tag_list = "summer, sale"
    product.save!
  
    expect(SolidusProductTags::ProductTagging.count).to eq(2)
  
    product.destroy
  
    expect(SolidusProductTags::ProductTagging.count).to eq(0)
  end
end

