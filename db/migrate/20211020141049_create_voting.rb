class CreateVoting < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :vote, :integer

  end
end
