# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, presence: true
  validates :count, presence: true
end
