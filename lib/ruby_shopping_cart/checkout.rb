# frozen_string_literal: true

module RubyShoppingCart
  class Checkout
    def initialize(promotional_rules)
      @promotional_rules = promotional_rules
    end

    def scan(_item)
      puts 'done'
    end

    def total
      puts 'done'
    end

    private

    attr_reader :promotional_rules
  end
end
