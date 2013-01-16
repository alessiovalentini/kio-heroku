class AddLastModifiedDateToNews < ActiveRecord::Migration
  def change
    add_column :news, :last_modified_date, :datetime
  end
end
