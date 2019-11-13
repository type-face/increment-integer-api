class AddIncrementerToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :incrementer, :int, default: 0
  end
end
