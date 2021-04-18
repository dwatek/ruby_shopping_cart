# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    code { '001' }
    name { 'Red Scarf' }
    price { 9.25 }
  end
end
