# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

$LOAD_PATH.unshift File.expand_path('..', __dir__)

require 'app/models/product'
require 'app/models/promotion'

Product.create!(code: '001', name: 'Red Scarf', price: 9.25)
Product.create!(code: '002', name: 'Silver cufflinks', price: 45.00)
Product.create!(code: '003', name: 'Silk Dress', price: 19.95)

Promotion.create!(promotion_type: 'product', product_code: '001', condition: 2, discount: 0.75)
Promotion.create!(promotion_type: 'checkout', condition: 60, discount: 10)
