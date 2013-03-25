class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :chronicle_id
      t.string :title
      t.string :image_url
      t.datetime :start_date
      t.datetime :end_date
      t.string :location
      t.decimal :longitude
      t.decimal :latitude
      t.text :description
      t.text :properties

      t.timestamps
    end
  end
end
