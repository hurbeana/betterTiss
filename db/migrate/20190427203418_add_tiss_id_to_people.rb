class AddTissIdToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :tiss_id, :string
  end
end
