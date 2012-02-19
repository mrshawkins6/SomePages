class CreateNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.string :title
      t.string :description
      t.integer :user_id
      t.integer :anketka_id

      t.timestamps
    end
  end
end
