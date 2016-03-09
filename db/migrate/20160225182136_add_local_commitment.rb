class AddLocalCommitment < ActiveRecord::Migration
  def change
  	add_column :users, :local_commitment, :string
  end
end
