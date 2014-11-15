class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end
