# frozen_string_literal: true

class AddTitleToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :title, :string
  end
end
