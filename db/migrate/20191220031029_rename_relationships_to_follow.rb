# frozen_string_literal: true

class RenameRelationshipsToFollow < ActiveRecord::Migration[6.0]
  def change
    rename_table :relationships, :follows
  end
end
