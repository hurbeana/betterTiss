class AddTimeStampToPeopleUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :people_users, :created_at, :datetime
  end
end
