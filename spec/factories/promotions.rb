# frozen_string_literal: true

FactoryBot.define do
  factory :promotion do
    promotion_type { 'product' }
    product_code { nil }
    condition { 2 }
    discount { 0.75 }
  end
end
