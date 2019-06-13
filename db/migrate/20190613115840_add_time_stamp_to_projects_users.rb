class AddTimeStampToProjectsUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :projects_users, :created_at, :datetime
  end
end
