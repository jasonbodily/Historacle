class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.text :coordinates

      t.timestamps
    end
  end
end
