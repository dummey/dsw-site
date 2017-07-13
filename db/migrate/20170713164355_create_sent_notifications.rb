# frozen_string_literal: true

class CreateSentNotifications < ActiveRecord::Migration
  def change
    create_table :sent_notifications do |t|
      t.references :submission, index: true, foreign_key: true
      t.string :kind, null: false
      t.string :recipient_email, null: false
      t.text :body

      t.timestamps null: false
    end
  end
end
