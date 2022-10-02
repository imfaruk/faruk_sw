# frozen_string_literal: true

class Ticket < ApplicationRecord
  validates :user_id, presence: true
  validates :title, presence: true
  validates :generated_at, presence: true
end
