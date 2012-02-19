class CreateAnketa < ActiveRecord::Migration
  def change
    create_table :anketa do |t|
      t.integer :notebook_id
      t.string :title

      t.timestamps
    end
  end
end
