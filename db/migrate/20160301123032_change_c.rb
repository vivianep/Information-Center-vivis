class ChangeC < ActiveRecord::Migration
  def change
  	change_column :archives, :updated_at, :string, after: :local_commitment
  end
end
