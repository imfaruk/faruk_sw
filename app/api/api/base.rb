# frozen_string_literal: true

module API
  class Base < Grape::API
    require_relative '../../../lib/api/validations/array_length'

    version 'v1', using: :path
    format :json
    prefix :api

    #
    # Strong Parameters
    #
    helpers do
      def permitted_params
        @permitted_params ||= declared(params, include_missing: false)
      end
    end

    include API::ExceptionHandling

    mount API::Resources::Tickets
  end
end
