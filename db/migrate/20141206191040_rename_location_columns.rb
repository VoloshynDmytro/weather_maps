class RenameLocationColumns < ActiveRecord::Migration
  def change
    rename_column :locations, :lat, :latitude
    rename_column :locations, :lng, :longitude
  end
end
