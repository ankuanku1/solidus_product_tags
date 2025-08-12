# frozen_string_literal: true

require_relative "solidus_product_tags/version"
require "solidus_core"
require "solidus_backend"
require "solidus_support"

require "solidus_product_tags/version"
require "solidus_product_tags/engine"

module SolidusProductTags
  class Error < StandardError; end
end
