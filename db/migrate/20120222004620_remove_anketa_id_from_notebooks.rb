class RemoveAnketaIdFromNotebooks < ActiveRecord::Migration
  def up
    remove_column :notebooks, :anketka_id
  end

  def down
    add_column :notebooks, :anketka_id, :integer
  end
end
