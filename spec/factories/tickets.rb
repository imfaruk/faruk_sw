# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    title { 'A title' }
    user_id { 1234 }
    generated_at { DateTime.current }
  end
end
