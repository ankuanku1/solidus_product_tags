# SolidusProductTags

A simple Solidus extension for tagging products via the admin interface.

## Installation

Add this line to your application's Gemfile:

```bash
gem 'solidus_product_tags', github: 'ankuanku1/solidus_product_tags'```
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
