# SolidusProductTags

A simple Solidus extension for tagging products via the admin interface.
Allows for flexible grouping without relying on taxonomies or categories,
useful for custom sorting or search features based on tags.

## Features

- Add and manage tags through the Solidus admin panel
- Assign tags via console or scripts
- Query products by tags
- Tags are normalized (case-insensitive, stripped, and unique)


## Installation

Add this line to your application's Gemfile:

```bash
gem 'solidus_product_tags', github: 'ankuanku1/solidus_product_tags'
```
Then run:

```bash
bundle install
```

Run the installer to copy over migrations:

```bash
bin/rails generate solidus_product_tags:install
```
Finally, migrate the database:

```bash
bin/rails db:migrate
```


## Usage

Navigate to the admin products page.
Create/edit a product and add tags.

Tags can also be added and read from the Rails console:

```bash
product = Spree::Product.find_by(slug: "your-product-slug")
product.tag_list = "summer, sale, limited"
product.save!
```

```bash
product.tags.map(&:name)
# => ["summer", "sale", "limited"]

product.tag_list
# => "summer, sale, limited"

# => To find all products tagged with "summer":
Spree::Product.joins(:tags).where(solidus_product_tags_tags: { name: "summer" }).distinct
```