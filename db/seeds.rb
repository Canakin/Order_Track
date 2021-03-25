# Seed file for our database where we create our objects for our database

require 'json'
require 'open-uri'

puts 'destroying all objects'

User.destroy_all
Customer.destroy_all
Order.destroy_all
Product.destroy_all

puts "destroyed all objects"
sleep(2)
puts "creating users"

userone = User.create!(email:'scan.cimenser@gmail.com',password:'can13579',nickname:'canakin',first_name:'Can',last_name:'Cimenser', company_name:'Tekfen Holding', address:'Zeytinoglu Street No:9 Akatlar/Besiktas İstanbul', profession:'Finance')
puts 'users created!'

photoone = URI.open("https://res.cloudinary.com/ds2odybte/image/upload/v1615810185/Can_Photo_bxbudx.jpg")
userone.photo.attach(io:photoone, filename:'Can_Cimenser.jpeg', content_type: 'photos/jpeg')
puts "photo attached to user"

puts 'creating customers'
url = "https://northwind.netcore.io/customers.json"
customers_serialized = open(url).read
customers_list = JSON.parse(customers_serialized)

customers_list["customers"].each do |customer|
  fax_number = customer["fax"].blank? ? "No Fax":customer["fax"]
  postal_c = customer["postalCode"].blank? ? "No Postal Code":customer["postalCode"]
  Customer.create!(company_name: customer["companyName"], contact_title: customer["contactName"],address:customer["address"], city:customer["city"], postal_code:postal_c, country: customer["country"], phone:customer["phone"], fax:fax_number, customer_id:customer["id"])
end

puts "customers created!"

urlsecond = "https://northwind.netcore.io/orders.json"
orders_serilized = open(urlsecond).read
orders_list = JSON.parse(orders_serilized)

puts "creating orders!"

orders_list["results"].each do |result|
  Customer.all.each do |customer|
    if result["order"]["customerId"] == customer.customer_id
      ordercustomer = customer
      ship_postal = result["order"]["shipPostalCode"].blank? ? "No postal": result["order"]["shipPostalCode"]
      neworder = Order.create!(employee_id:result["order"]["employeeId"],order_date:result["order"]["orderDate"], require_date:result["order"]["requiredDate"], ship_via:result["order"]["shipVia"], freight: result["order"]["freight"], ship_name: result["order"]["shipName"], ship_adress: result["order"]["shipAddress"], ship_city:result["order"]["shipCity"], ship_postal_code:ship_postal, shio_country:result["order"]["shipCountry"],customer: ordercustomer, orderid:result["order"]["id"])
      result["orderDetails"].each do |orderdetails|
        Product.create!(unit_price:orderdetails["unitPrice"], quantity:orderdetails["quantity"], discount:orderdetails["discount"], productid: orderdetails["productId"],order:neworder)
      end
    end
  end
end

puts "Orders & Product created successfully !"
