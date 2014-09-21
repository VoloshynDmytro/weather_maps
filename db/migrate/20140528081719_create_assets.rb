class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :attachable, polymorphic: true

      t.string :title
      t.string :description
      t.string :type
      t.timestamps
    end
  end
end
