class AddColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :user_id, :integer
    change_column :tweets, :content, :string 
  end
end
