# frozen_string_literal: true

class CheckoutDiscountCalculator
  NON_DISCOUNT_VALUE = 0

  def initialize(promotion, total)
    @promotion = promotion
    @total = total
  end

  def call
    promotion_applicable? ? discount_value : NON_DISCOUNT_VALUE
  end

  private

  attr_reader :promotion, :total

  def promotion_applicable?
    total > promotion.condition
  end

  def discount_value
    (total * promotion.discount / 100)
  end
end
