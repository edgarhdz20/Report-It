class AddStatusToReport < ActiveRecord::Migration
  def change
    add_column :reports, :status, :boolean
  end
end
