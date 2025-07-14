module SolidusProductTags
  module Admin
    class TagInputComponent < ViewComponent::Base
      def initialize(form:, product:)
        @form = form
        @product = product
      end

      def call
        content_tag :div, class: "space-y-2" do
          @form.label(:tag_list, "Tags (comma separated)") +
          @form.text_field(:tag_list, value: @product.tag_list, class: "w-full border rounded p-2")
        end
      end
    end
  end
end
