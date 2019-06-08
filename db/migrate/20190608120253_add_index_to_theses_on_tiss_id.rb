class AddIndexToThesesOnTissId < ActiveRecord::Migration[5.2]
  def change
    add_index :theses, :tiss_id
  end
end
