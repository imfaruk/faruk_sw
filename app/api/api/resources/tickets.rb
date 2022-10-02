# frozen_string_literal: true

module API
  module Resources
    class Tickets < Grape::API
      resources :tickets do
        desc 'Create Ticket'
        params do
          requires :user_id, type: Integer
          requires :title, type: String
          optional :tags, type: Array[String], array_length: 5
        end

        post do
          ticket = FactoryBot.create(:ticket)
          present ticket, with: API::Entities::Ticket
        end
      end
    end
  end
end
