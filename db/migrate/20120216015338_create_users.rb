class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :provider
      t.integer :provider_id
      t.date :birthdate
      t.string :email

      t.timestamps
    end
  end
  
  def down
	  drop_table :users
  end
end
