class CustomersController < ApplicationController
  before_action :find_customer, only: [:show, :edit, :update, :destroy]
  def index
    searching
    set_marker
  end

  def show
    @order_list = @customer.orders
    if @order_list.blank?
      @orders = "Customer currently has no order"
    else
      @orders = @order_list
    end
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save!
      redirect_to customers_path
    else
      render "/customer/new"
    end
  end

  def edit; end

  def update
    if @customer.update!(customer_params)
      redirect_to customers_path
    else
      render 'customers/:id/edit'
    end
  end

  def destroy
    if @customer.orders.blank?
      @customer.destroy
      redirect_to customers_path
    else
      redirect_to customer_path(@customer), alert: "First delete the order, then you can delete the customer!!"
    end
  end

  private

  def find_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:company_name, :customer_id, :contact_title, :address, :city, :postal_code, :country, :phone, :fax)
  end

  def searching
    # Both searching and filtering method
    if params[:query].present?
      sql_query = " \
        customers.company_name @@ :query \
        OR customers.country @@ :query \
        OR customers.city @@ :query \
      "
      if params[:orders].present?
        @customers = []
        Customer.where(sql_query, query: "%#{params[:query]}%").each { |customer| customer.orders.exists? ? @customers << customer : @customers }
      else
        @customers = Customer.where(sql_query, query: "%#{params[:query]}%")
      end
    else
      @customers = Customer.all
    end
  end

  def set_marker
    # Settings markers list consisting of coordinates of cities that our customer is located
    @markers = []
    Customer.all.each { |customer| @markers << { lat: customer.latitude, lng: customer.longitude } }
  end
end
