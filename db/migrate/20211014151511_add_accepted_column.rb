class AddAcceptedColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :comments,:accepted,:boolean,default: false ,null: false
  end
end
