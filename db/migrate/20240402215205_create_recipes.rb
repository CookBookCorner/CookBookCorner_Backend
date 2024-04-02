class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.integer :preparation_time
      t.integer :cooking_time
      t.integer :servings
      t.string :difficulty
      t.text :instructions
      t.text :notes

      t.timestamps
    end
  end
end
