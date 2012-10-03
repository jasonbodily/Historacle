class CreateChronicles < ActiveRecord::Migration
  def change
    create_table :chronicles do |t|
      t.integer :library_id
      t.string :name
      t.text :description
      t.string :subject
      t.string :value1_title
      t.boolean :use_value1
      t.string :value2_title
      t.boolean :use_value2
      t.string :value3_title
      t.boolean :use_value3

      t.timestamps
    end
  end
end
