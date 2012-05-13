class RemoveNotebooks < ActiveRecord::Migration
  def up
	drop_table :notebooks
  end

  def down
  end
end
