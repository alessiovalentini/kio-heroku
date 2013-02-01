class AddLatitudeAndLongitudeToGrounds < ActiveRecord::Migration
  def change
    add_column :grounds, :latitude, :float
    add_column :grounds, :longitude, :float
  end
end
