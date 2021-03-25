class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :employee_id
      t.string :order_date
      t.string :require_date
      t.string :ship_via
      t.string :integer
      t.string :freight
      t.string :float
      t.string :ship_name
      t.string :ship_adress
      t.string :ship_city
      t.string :ship_postal_code
      t.string :shio_country
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
