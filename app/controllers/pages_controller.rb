class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :stdev, only: [:stats]
  before_action :grouping_country, only: [:stats]
  before_action :grouping_ship_country, only: [:stats]
  before_action :grouping_order_freight, only: [:stats]
  before_action :freight_stats, only: [:stats]
  def home
    @user = current_user
  end

  def stats
    # sample size data
    @sample_size = Product.all.size
    # product prices descriptive stats methods
    @average_price = Product.average("unit_price").round(1)
    @max_price = Product.maximum("unit_price").round(1)
    @min_price = Product.minimum("unit_price").round(1)
    # product quantity descriptive stats methods
    @average_quantity = Product.average("quantity").to_i
    @max_quant = Product.maximum("quantity")
    @min_quant = Product.minimum("quantity")
    # discount descriptive stats method
    @average_discount = Product.average("discount").round(1)
    @max_discount = Product.maximum("discount").round(1)
    @min_discount = Product.minimum("discount").round(1)
  end

  def dashboard
    @fullname = "#{current_user.first_name} #{current_user.last_name}"
    @nickname = current_user.nickname
    @company_name = current_user.company_name
    @email = current_user.email
    @address = current_user.address
    @profession = current_user.profession
    @counter = 0
    products = []
    @feedbacks = Feedback.all.each { |feedback| feedback.user == current_user ? @counter += 1 : @counter }
    @feedback_product = Feedback.all.each { |feedback| feedback.user == current_user ? products << feedback : products }
  end

  private

  def stdev
    sum_price = 0
    sum_quant = 0
    sum_discount = 0
    Product.all.each { |product| sum_price += (product.unit_price.to_i - Product.average("unit_price").to_i).abs }
    @std_price = sum_price.to_i / Product.all.count
    Product.all.each { |product| sum_quant += (product.quantity.to_i - Product.average("quantity").to_i).abs }
    @std_quant = sum_quant.to_i / Product.all.count
    Product.all.each { |product| sum_discount += (product.discount.to_f - Product.average("discount").to_f).abs }
    @std_discount = (sum_discount.to_f / Product.all.count).round(1)
  end

  def grouping_country
    @customer_dist = Customer.group(:country).count
    list_one = []
    @customer_dist.each_key do |key|
      list_one << { label: key, y: @customer_dist[key] }
    end
    @new_list = list_one.to_json
  end

  def grouping_ship_country
    @order_dist = Order.group(:shio_country).count
    list_one_order = []
    @order_dist.each_key do |key|
      list_one_order << { label: key, y: @order_dist[key] }
    end
    @new_order_list = list_one_order.to_json
  end

  def grouping_order_freight
    @order_sample = Order.all.count
    order_freights = []
    Order.all.each do |order|
      order_freights << { label: "Order ID:#{order.orderid}", y: order.freight.to_f }
    end
    @new_order_freight = order_freights.to_json
  end

  def freight_stats
    sum_dev = 0
    freight_list = []
    Order.all.each do |order|
      freight_list << order.freight.to_f
    end
    @average_freight = (freight_list.sum / Order.all.count).round(1)
    @max_freight = freight_list.max { |a, b| a <=> b }.round(1)
    @min_freight = freight_list.min { |a, b| a <=> b }.round(1)
    freight_list.each { |freight| sum_dev += (freight.to_f - @average_freight.to_f).abs }
    @std_freight = (sum_dev / freight_list.size).round(1)
  end
end
