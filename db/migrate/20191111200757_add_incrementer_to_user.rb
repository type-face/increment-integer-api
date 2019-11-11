class AddIncrementerToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :incrementer, :int, default: 0
  end
end
