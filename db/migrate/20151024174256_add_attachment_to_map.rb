class AddAttachmentToMap < ActiveRecord::Migration
  def change
    add_column :maps, :attachment, :string
  end
end
