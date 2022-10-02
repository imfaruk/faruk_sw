# frozen_string_literal: true

module API
  module Entities
    class Base < Grape::Entity
      format_with(:timestamp) { |time| time.to_i if time.present? }
    end
  end
end
