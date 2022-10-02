# frozen_string_literal: true

class TagsCreateService
  attr_reader :tags

  def self.call(tags)
    new(tags).call
  end

  def call
    return if tags.blank?

    update_tags
    create_tags
  end

  private

  def initialize(tags)
    @tags = tags
  end

  def create_tags
    new_tags.each do |tag|
      Tag.create!(name: tag)
    end
  end

  def update_tags
    # `update_all` does not hit callbacks but in this scenario we can skip that in favour of performance
    existing_tags.update_all('count = count + 1')
  end

  def existing_tags
    @existing_tags ||= Tag.where(name: tags)
  end

  def new_tags
    tags - existing_tags.pluck(:name)
  end
end
