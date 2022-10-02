# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotifyTagCountJob, type: :job do
  subject(:perform_worker) { described_class.new.perform }

  before do
    allow_any_instance_of(described_class).to receive(:send_webhook_request).and_return(true)
  end

  describe '#perform_later' do
    it 'notify webhook' do
      ActiveJob::Base.queue_adapter = :test
      NotifyTagCountJob.perform_later
      expect(NotifyTagCountJob).to have_been_enqueued
    end
  end

  describe '#perform' do
    it 'returns expected result' do
      expect(perform_worker).to eq(true)
    end

    context 'when error raised' do
      before do
        allow_any_instance_of(described_class).to receive(:send_webhook_request).and_raise('boom')
      end

      it 'raise exception' do
        expect { perform_worker }.to raise_error('boom')
      end
    end
  end
end
