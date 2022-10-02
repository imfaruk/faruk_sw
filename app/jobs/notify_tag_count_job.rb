# frozen_string_literal: true

class NotifyTagCountJob < ApplicationJob
  queue_as :default

  def perform
    send_webhook_request
  rescue StandardError => e
    failed(class: e.class.name, message: e.message)
    raise(e)
  end

  private

  def send_webhook_request
    uri = URI(ENV['WEBHOOK_URL'])
    uri.query = URI.encode_www_form(params)
    Net::HTTP.get_response(uri)
  end

  def params
    {
      tag: tag_with_highest_count.name,
      count: tag_with_highest_count.count
    }
  end

  def tag_with_highest_count
    @tag_with_highest_count ||= Tag.order(count: :desc).limit(1).first
  end

  def failed(**error_data)
    Rails.logger.error("Webhook request failed, error: #{error_data}")
  end
end
