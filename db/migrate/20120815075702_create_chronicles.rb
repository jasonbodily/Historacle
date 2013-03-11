class CreateChronicles < ActiveRecord::Migration
  def change
    create_table :chronicles do |t|
      t.integer :library_id
      t.string :name
      t.text :description
      t.string :subject

      t.timestamps
    end
  end
end
