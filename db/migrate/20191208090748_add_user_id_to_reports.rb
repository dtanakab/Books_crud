# frozen_string_literal: true

class AddUserIdToReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :reports, :user, index: true
  end
end
