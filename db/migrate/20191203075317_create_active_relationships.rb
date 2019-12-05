# frozen_string_literal: true

class CreateActiveRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :active_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :active_relationships, :followed_id
    add_index :active_relationships, :follower_id
    add_index :active_relationships, %i[followed_id follower_id], unique: true
  end
end
