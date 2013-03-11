class CreateChronicleFields < ActiveRecord::Migration
  def change
    create_table :chronicle_fields do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.belongs_to :chronicle

      t.timestamps
    end
    add_index :chronicle_fields, :chronicle_id
  end
end
