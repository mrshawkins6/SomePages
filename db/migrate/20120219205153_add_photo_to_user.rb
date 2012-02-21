class AddPhotoToUser < ActiveRecord::Migration
  def change
	add_column :users, :photo, :string
  end
    
  def down
	remove_column :users, :photo  
  end
end
