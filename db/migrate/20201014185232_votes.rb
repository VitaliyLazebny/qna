# frozen_string_literal: true

class Votes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false, index: true
      t.text    :votable_type, null: false
      t.integer :votable_id, null: false
      t.integer :value, limit: 1

      t.timestamps
    end
  end
end
