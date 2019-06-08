class CreateJoinTablePeopleUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :people, :users do |t|
      t.index [:person_id, :user_id]
      t.index [:user_id, :person_id]
    end
  end
end
