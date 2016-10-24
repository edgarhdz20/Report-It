class AddAvatarToReports < ActiveRecord::Migration
  def change
    add_column :reports, :avatar, :string
  end
end
