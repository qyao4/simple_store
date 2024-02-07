# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Test create an invalid product
# product = Product.create(title: nil, price: -10, stock_quantity: -1)

# if product.persisted?
#   puts "Product was saved successfully, which should not happen."
# else
#   puts "Failed to save product, as expected:"
#   puts product.errors.full_messages
# end

# Populate the products table with 676 products
# 676.times do
#   Product.create!(
#     title: Faker::Commerce.product_name,
#     price: Faker::Commerce.price(range: 0.01..100.0),
#     stock_quantity: Faker::Number.between(from: 1, to: 100)
#   )
# end
# puts "Created 676 products."

require 'csv'

# Clear out the existing data
Product.destroy_all
Category.destroy_all

# Set the path to the CSV file
csv_file = Rails.root.join('db/products.csv')

# Read the CSV data
csv_data = File.read(csv_file)

# Parse the CSV data with headers in windows
products = CSV.parse(csv_data, headers: true, encoding: 'utf-8')

products.each do |row|
  category_name = row['category'] # Adjust the header name if necessary

  # Find the category by name, or create it if it doesn't exist
  category = Category.find_or_create_by!(name: category_name)

  # Now create a product associated with this category
  Product.create!(
    title: row['name'], # 'name' header for the product's title
    price: row['price'].to_d, # Convert price to decimal
    description: row['description'],
    stock_quantity: row['stock quantity'].to_i, # Convert stock quantity to integer
    category: category  # Set the category_id foreign key
  )
end

puts "Imported #{products.size} products"
