class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :recordId
      t.string :title
      t.text :body
      t.datetime :date
      t.string :newsImageUrl

      t.timestamps
    end
  end
end
