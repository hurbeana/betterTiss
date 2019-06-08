class AddIndexToPeopleOnTissId < ActiveRecord::Migration[5.2]
  def change
    add_index :people, :tiss_id
  end
end
