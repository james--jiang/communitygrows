class AddExternalToUser < ActiveRecord::Migration
  def change
    add_column :users, :external, :bool
  end
end
