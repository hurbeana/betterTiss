class AddIndexToCoursesOnTissId < ActiveRecord::Migration[5.2]
  def change
    add_index :courses, :tiss_id
  end
end
