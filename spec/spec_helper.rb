# frozen_string_literal: true

require 'bundler/setup'
require 'solidus_product_tags'

# Load models
Dir["#{__dir__}/../app/models/solidus_product_tags/*.rb"].each { |f| require f }

require 'active_record'

# In-memory database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :dummy_products, force: true do |t|
    t.string :name
    t.timestamps
  end

  create_table :solidus_product_tags_tags, force: true do |t|
    t.string :name
    t.timestamps
  end

  create_table :solidus_product_tags_product_taggings, force: true do |t|
    t.integer :product_id
    t.integer :tag_id
    t.timestamps
  end
end

require_relative '../app/models/solidus_product_tags/tag'
require_relative '../app/models/solidus_product_tags/product_taggable'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
