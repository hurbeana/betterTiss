class AddIndexToProjectsOnTissId < ActiveRecord::Migration[5.2]
  def change
    add_index :projects, :tiss_id
  end
end
