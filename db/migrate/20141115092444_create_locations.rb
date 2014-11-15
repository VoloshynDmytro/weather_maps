class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :city
      t.string :country
      t.string :district
      t.string :address
      t.string :lat
      t.string :lng
      t.references :user, index: true
      t.timestamps
    end
  end
end
