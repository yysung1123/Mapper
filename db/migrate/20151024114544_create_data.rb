class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.string :address
      t.integer :map_id

      t.timestamps null: false
    end
  end
end
