class AddTimeStampToCoursesUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :courses_users, :created_at, :datetime
  end
end
