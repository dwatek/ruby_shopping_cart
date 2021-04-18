# frozen_string_literal: true

class Product < ActiveRecord::Base
  validates_uniqueness_of :code
end
