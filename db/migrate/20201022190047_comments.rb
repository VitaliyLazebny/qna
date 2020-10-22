# frozen_string_literal: true

class Comments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false, index: true
      t.text    :commentable_type, null: false
      t.integer :commentable_id, null: false
      t.text    :body, limit: 255

      t.timestamps
    end
  end
end
