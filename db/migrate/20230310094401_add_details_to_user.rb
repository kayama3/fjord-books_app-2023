class AddDetailsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :post_code, :integer
    add_column :users, :address, :string
    add_column :users, :biography, :string
  end
end
