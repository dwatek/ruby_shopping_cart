# frozen_string_literal: true

class Checkout
  def initialize(promotional_rules = [])
    @promotional_rules = promotional_rules
    @products = []
  end

  def scan(code)
    products << Product.find_by!(code: code)
  end

  def total
    (products_total_price - discounts).to_f.round(2)
  end

  private

  attr_reader :promotional_rules, :products

  def products_total_price
    products.map(&:price).sum
  end

  def discounts
    products_discounts + checkout_discount
  end

  def products_discounts
    product_promotions.map { |promotion| ProductDiscountCalculator.new(promotion, products).call }.sum
  end

  def checkout_discount
    checkout_promotions.map do |promotion|
      CheckoutDiscountCalculator.new(promotion, products_price_with_products_discount).call
    end.sum
  end

  def product_promotions
    promotional_rules.empty? ? promotional_rules : promotional_rules.where(promotion_type: 'product')
  end

  def checkout_promotions
    promotional_rules.empty? ? promotional_rules : promotional_rules.where(promotion_type: 'checkout')
  end

  def products_price_with_products_discount
    products_total_price - products_discounts
  end
end
