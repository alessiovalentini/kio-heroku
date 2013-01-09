class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :recordId
      t.string :groundId
      t.string :block
      t.string :row
      t.string :seat
      t.string :otherGroundName
      t.text :otherGroundDescription
      t.datetime :reportDate
      t.text :description
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.string :lat
      t.string :lng
      t.string :abuseType

      t.timestamps
    end
  end
end
