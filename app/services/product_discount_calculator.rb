# frozen_string_literal: true

class ProductDiscountCalculator
  NON_DISCOUNT_VALUE = 0

  def initialize(promotion, products)
    @promotion = promotion
    @products = products
  end

  def call
    promotion_applicable? ? discount_value : NON_DISCOUNT_VALUE
  end

  private

  attr_reader :promotion, :products

  def promotion_applicable?
    promotion_products_quantity >= promotion.condition
  end

  def discount_value
    promotion_products_quantity * promotion.discount
  end

  def promotion_products_quantity
    products.select { |product| product.code == promotion.product_code }.size
  end
end
