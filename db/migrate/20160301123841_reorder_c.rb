class ReorderC < ActiveRecord::Migration
  def change
  	change_column :archives, :local_commitment, :string, after: :owner
  end
end
