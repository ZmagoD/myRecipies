class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :chef, index: true, foreign_key: true
      t.references :recipe, index: true, foreign_key: true
      t.text :comment
      t.timestamps null: false
    end
  end
end
