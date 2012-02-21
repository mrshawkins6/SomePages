class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :anketum_id
      t.string :title
      t.integer :type
      t.string :body

      t.timestamps
    end
  end
end
