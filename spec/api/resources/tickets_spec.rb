# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::Resources::Tickets do
  include Rack::Test::Methods

  describe 'POST /ticket' do
    let(:request_url) { '/api/v1/tickets' }

    let(:ticket_params) do
      {
        title: 'A ticket Title',
        user_id: 1,
        tags: %w[atag btag]
      }
    end

    context 'incomplete parameters' do
      it 'requires title' do
        response = post request_url, ticket_params.except(:title)
        expect(response.status).to eq(422)
      end

      it 'requires user_id' do
        response = post request_url, ticket_params.except(:user_id)
        expect(response.status).to eq(422)
      end

      it 'does not require tags' do
        response = post request_url, ticket_params.except(:tags)
        expect(response.status).to eq(201)
      end

      it 'requires at most 5 tags' do
        tags = %w[a b c d e f]
        params = ticket_params.merge(tags:)

        response = post request_url, params
        expect(response.status).to eq(422)
      end

      it 'returns error response of application/json type' do
        response = post request_url, {}
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'complete parameters' do
      it 'returns a response of application/json type' do
        response = post request_url, ticket_params
        expect(response.content_type).to eq('application/json')
      end

      it 'returns results with respond code 201' do
        response = post request_url, ticket_params
        expect(response.status).to eq(201)
      end
    end
  end
end
