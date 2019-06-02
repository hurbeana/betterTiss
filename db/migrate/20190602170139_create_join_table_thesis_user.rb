class CreateJoinTableThesisUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :theses, :users do |t|
      # t.index [:thesis_id, :user_id]
      # t.index [:user_id, :thesis_id]
    end
  end
end
