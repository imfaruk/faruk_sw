# frozen_string_literal: true

class TicketCreateEntrypoint
  attr_reader :params

  def self.call(params)
    new(params).call
  end

  def call
    ActiveRecord::Base.transaction do
      ticket = Ticket.create!(ticket_params)
      TagsCreateService.call(tags)
      NotifyTagCountJob.perform_later # Ideally a queuing backends (Sidekiq, Resque) should be used
      ticket
    end
  end

  private

  def initialize(params)
    @params = params
  end

  def ticket_params
    params.except(:tags).merge(generated_at: DateTime.current)
  end

  def tags
    params[:tags]
  end
end
