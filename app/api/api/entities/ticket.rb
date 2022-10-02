# frozen_string_literal: true

module API
  module Entities
    class Ticket < API::Entities::Base
      expose :id
      expose :user_id
      expose :title
      with_options(format_with: :timestamp) do
        expose :generated_at
      end
    end
  end
end
