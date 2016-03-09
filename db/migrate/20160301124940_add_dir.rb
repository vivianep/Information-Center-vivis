class AddDir < ActiveRecord::Migration
  def change
  	add_column :archives, :dir, :boolean, default: false
  end
end
