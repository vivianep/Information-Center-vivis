class AddPathColumn < ActiveRecord::Migration
  #Take note that if the file was uploaded and did not went to the right directory it could be at root /
  def change
  	add_column :archives, :path, :string, default: "/"
  end
end
