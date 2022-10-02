# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false, index: true
      t.bigint :count, null: false, default: 1
      t.timestamps
    end
  end
end
