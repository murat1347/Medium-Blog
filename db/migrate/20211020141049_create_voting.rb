class CreateVoting < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :vote, :integer,default: 0

  end
end
