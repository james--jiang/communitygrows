class AddExecutiveToUser < ActiveRecord::Migration
  def change
    add_column :users, :executive, :bool
  end
end
