# frozen_string_literal: true

class Product < ActiveRecord::Base
  validates :name, :price, presence: true
  validates_uniqueness_of :code
end
