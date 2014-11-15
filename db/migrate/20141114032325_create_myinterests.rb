class CreateMyinterests < ActiveRecord::Migration
  def change
    create_table :myinterests do |t|
      t.references :user
      t.references :selectable,  polymorphic: true    

      t.timestamps
    end
  end
end
