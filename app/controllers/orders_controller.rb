class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update, :destroy]
  def index
    searching
  end

  def show; end

  def new
    @order = Order.new
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @product = Product.find(params[:product_id])
    @order = Order.new(order_params)
    @order.customer = @customer
    @order.product = @product
    if @order.save!
      redirect_to orders_path
    else
      render new_order_path
    end
  end

  def edit; end

  def update
    if @order.update!(order_params)
      redirect_to orders_path
    else
      render edit_order_path
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private

  def searching
    if params[:query].present?
      sql_query = "\
        employee_id @@ :query \
        OR shio_country @@ :query \
        OR ship_city @@ :query \
        OR ship_postal_code @@ :query \
        OR ship_name @@ :query \
        "
      if params[:products].present?
        orders_with_products = []
        Order.where(sql_query, query: "%#{params[:query]}%").each { |order| order.products.count > 1 ? orders_with_products << order : orders_with_products }
        @orders = orders_with_products
      else
        @orders = Order.where(sql_query, query: "%#{params[:query]}%")
      end
    else
      @orders = Order.all
    end
  end

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:employee_id, :order_date, :require_date, :ship_via, :freight, :ship_name, :ship_adress, :ship_city, :ship_postal_code, :shio_country, :orderid, :customer_id)
  end
end
