class AddInternalToUser < ActiveRecord::Migration
  def change
    add_column :users, :internal, :bool
  end
end
