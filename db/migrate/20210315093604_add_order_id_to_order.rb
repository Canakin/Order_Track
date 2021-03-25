class AddOrderIdToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :orderid, :string
  end
end
