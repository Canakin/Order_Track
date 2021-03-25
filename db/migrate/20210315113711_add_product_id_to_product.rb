class AddProductIdToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :productid, :string
  end
end
