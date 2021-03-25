class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :company_name
      t.string :contact_title
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :country
      t.string :phone
      t.string :fax

      t.timestamps
    end
  end
end
