# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::Entities::Ticket do
  let(:ticket) { FactoryBot.create(:ticket) }

  let(:ticket_entity) { API::Entities::Ticket.represent(ticket) }

  subject { JSON.parse(ticket_entity.to_json) }

  it 'matches the api specification' do
    expect(subject)
      .to eq('id' => ticket.id, 'title' => ticket.title, 'user_id' => ticket.user_id,
             'generated_at' => ticket.generated_at.to_i)
  end
end
