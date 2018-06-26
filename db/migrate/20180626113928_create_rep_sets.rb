class CreateRepSets < ActiveRecord::Migration[5.0]
  def change
    create_table :rep_sets do |t|
      t.integer :workout_id
      t.integer :number
      t.string :rep_type

      t.timestamps
    end
  end
end
