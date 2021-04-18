# frozen_string_literal: true

class Checkout
  def initialize(promotional_rules = nil)
    @promotional_rules = promotional_rules
    @basket = []
  end

  def scan(code)
    basket << Product.find_by!(code: code)
  end

  def total
    (basket_total - (discount || 0)).round(2)
  end

  private

  attr_reader :promotional_rules, :basket

  def basket_total
    basket.map(&:price).sum
  end

  def discount
    (items_discounts || 0) + (basket_discounts || 0)
  end

  def basket_discounts
    # When spending over 60, the customer gets 10% off their purchase
    ((basket_total - items_discounts) * 10 / 100).to_f if basket_total.to_f > 60
  end

  def items_discounts
    # When purchasing 2 or more of the Red Scarf, its price is reduced to 8.50
    items = basket.select { |item| item.code == '001' }
    if items.size >= 2
      items.size * 0.75
    else
      0
    end
  end
end
