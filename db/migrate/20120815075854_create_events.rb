class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :date
      t.string :location
      t.decimal :longitude
      t.decimal :latitude
      t.text :description
      t.string :value1
      t.string :value2
      t.string :value3

      t.timestamps
    end
  end
end
