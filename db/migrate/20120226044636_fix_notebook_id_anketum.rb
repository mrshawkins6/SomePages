class FixNotebookIdAnketum < ActiveRecord::Migration
  def up
	rename_column :anketa, :notebook_id, :anketum_id
  end

  def down
  end
end
