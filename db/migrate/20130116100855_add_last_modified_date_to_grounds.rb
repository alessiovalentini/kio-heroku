class AddLastModifiedDateToGrounds < ActiveRecord::Migration
  def change
    add_column :grounds, :last_modified_date, :datetime
  end
end
