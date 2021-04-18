# frozen_string_literal: true

class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.string :promotion_type, null: false
      t.string :product_code
      t.bigint :condition, null: false
      t.decimal :discount, null: false
    end
  end
end
