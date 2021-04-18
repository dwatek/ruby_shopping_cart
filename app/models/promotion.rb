# frozen_string_literal: true

class Promotion < ActiveRecord::Base
  validates :condition, :discount, presence: true
end
