class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :gender
      t.string :country
      t.string :city
      t.string :screen_name
      t.string :relationship_status

      t.timestamps
    end
  end
end
