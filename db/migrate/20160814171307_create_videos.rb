# frozen_string_literal: true
class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :zype_id, null: false
      t.string :title, null: false
      t.jsonb :raw_payload, null: false

      t.timestamps
    end
  end
end
