class FixTypeQuestions < ActiveRecord::Migration
  def up
	rename_column :questions, :type, :variant
  end

  def down
  end
end
