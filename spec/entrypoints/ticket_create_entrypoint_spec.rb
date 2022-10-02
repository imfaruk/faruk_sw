# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketCreateEntrypoint do
  let(:params) do
    {
      title: 'ticket title',
      user_id: 1,
      tags: %w[atag btag]
    }
  end

  subject { TicketCreateEntrypoint.new(params) }

  describe '#call' do
    it 'creates a ticket' do
      expect { subject.call }.to change { Ticket.count }.by(1)
    end

    it 'calls TagsCreateService' do
      expect(TagsCreateService).to receive(:call)
      subject.call
    end

    it 'calls background job' do
      expect(NotifyTagCountJob).to receive(:perform_later)
      subject.call
    end
  end
end
