class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.float :unit_price
      t.integer :quantity
      t.float :discount
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
