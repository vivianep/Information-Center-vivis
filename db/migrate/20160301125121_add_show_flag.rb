class AddShowFlag < ActiveRecord::Migration
  def change
  	add_column :archives, :show, :boolean, default: true
  end
end
