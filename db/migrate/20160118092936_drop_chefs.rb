class DropChefs < ActiveRecord::Migration
  def change
    drop_table :chefs
  end
end
