# frozen_string_literal: true

class RenameActiveRelationshipsToRelationships < ActiveRecord::Migration[6.0]
  def change
    rename_table :active_relationships, :relationships
  end
end
