class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @order = Order.find(params[:order_id])
    @product = Product.new(product_params)
    @product.order = @order
    if @product.save!
      redirect_to order_path(@order)
    else
      render new_product_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:productid, :unit_price, :quantity, :discount, :order_id)
  end
end
