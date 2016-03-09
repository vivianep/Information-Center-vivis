class AddLcToFilesAndDirs < ActiveRecord::Migration
  def change
  	add_column :archives, :local_commitment, :string, :after => :owner
  	add_column :owners, :local_commitment, :string, :after => :name
  end
end
