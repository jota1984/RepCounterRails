class AddFinishedToWorkouts < ActiveRecord::Migration[5.0]
  def change
    add_column :workouts, :finished, :boolean
  end
end
