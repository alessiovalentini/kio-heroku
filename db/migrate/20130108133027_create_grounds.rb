class CreateGrounds < ActiveRecord::Migration
  def change
    create_table :grounds do |t|
      t.string :recordId
      t.string :groundName

      t.timestamps
    end
  end
end
