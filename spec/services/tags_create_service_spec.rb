# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TagsCreateService do
  let(:tag1) { 'tag1' }
  let(:tag2) { 'tag2' }
  let(:tag3) { 'tag3' }

  let(:tags) { [tag1, tag2, tag3] }
  let!(:persisted_tag) { FactoryBot.create(:tag, name: tag1) }

  let(:service_object) { described_class.new(tags) }

  describe '#call' do
    it 'creates new tags with count set to 1' do
      expect(Tag.where(name: [tag2, tag3]).count).to eq 0

      service_object.call

      expect(Tag.where(name: [tag2, tag3]).count).to eq(2)
      expect(Tag.where(name: [tag2, tag3]).pluck(:count)).to eq([1, 1])
    end

    it 'increases the count of persisted tag' do
      expect { service_object.call }.to change { persisted_tag.reload.count }.from(1).to(2)
    end
  end
end
