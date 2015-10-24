class AddLabelToData < ActiveRecord::Migration
  def change
    add_column :data, :label, :string
  end
end
