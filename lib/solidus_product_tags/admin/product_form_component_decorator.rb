module SolidusProductTags
  module Admin
    module ProductFormComponentDecorator
      def call
        original_content = super

        tag_input = render(
          SolidusProductTags::Admin::TagInputComponent.new(form: @form, product: @product)
        )
        Rails.logger.info("[solidus_product_tags] Rendering TagInputComponent...")

        original_content + tag_input
      end
    end
  end
end

