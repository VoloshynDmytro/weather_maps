class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.integer :temperature
      t.integer :humidity
      t.datetime :measured_at
      t.references :location, index: true

      t.timestamps
    end
  end
end
