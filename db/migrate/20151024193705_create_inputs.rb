class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.string :searchtext

      t.timestamps null: false
    end
  end
end
