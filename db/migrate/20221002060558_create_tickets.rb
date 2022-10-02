# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.bigint :user_id, null: false, index: true
      t.string :title, null: false
      t.datetime :generated_at, null: false
      t.timestamps
    end
  end
end
