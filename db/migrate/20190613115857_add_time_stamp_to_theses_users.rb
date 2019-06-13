class AddTimeStampToThesesUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :theses_users, :created_at, :datetime
  end
end
