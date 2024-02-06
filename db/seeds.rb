# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
product = Product.create(title: nil, price: -10, stock_quantity: -1)

if product.persisted?
  puts "Product was saved successfully, which should not happen."
else
  puts "Failed to save product, as expected:"
  puts product.errors.full_messages
end
