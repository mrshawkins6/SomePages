class FixNotebookIdAnketum2 < ActiveRecord::Migration
  def up
	rename_column :anketa, :anketum_id, :user_id
  end

  def down
  end
end
