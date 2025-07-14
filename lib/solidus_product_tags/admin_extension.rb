SolidusAdmin::Engine.configure do
  SolidusAdmin.register_page_section :product_form, :tags do |form:, product:|
    render SolidusProductTags::Admin::TagInputComponent.new(form: form, product: product)
  end
end
