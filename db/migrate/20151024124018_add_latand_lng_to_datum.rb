class AddLatandLngToDatum < ActiveRecord::Migration
  def change
    add_column :data, :lat, :float
    add_column :data, :lng, :float
  end
end
