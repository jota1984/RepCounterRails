class CreateBioEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :bio_entries do |t|
      t.references :workout, foreign_key: true
      t.float :temperature
      t.float :heart_rate
      t.datetime :date 
      t.timestamps
    end
  end
end
