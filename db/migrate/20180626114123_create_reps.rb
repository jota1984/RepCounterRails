class CreateReps < ActiveRecord::Migration[5.0]
  def change
    create_table :reps do |t|
      t.integer :rep_set_id
      t.string :rep_type
      t.datetime :date

      t.timestamps
    end
  end
end
