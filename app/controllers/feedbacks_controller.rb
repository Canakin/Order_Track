class FeedbacksController < ApplicationController
  before_action :find_feedback, only: [:edit, :destroy, :update]
  def new
    @feedback = Feedback.new
  end

  def create
    @product = Product.find(params[:product_id])
    @feedback = Feedback.new(feedback_params)
    @feedback.product = @product
    @feedback.user = current_user
    if @feedback.save!
      redirect_to product_path(@product)
    else
      render new_product_feedback_path
    end
  end

  def edit; end

  def update
    @product = Product.find(params[:product_id])
    if @feedback.update!(feedback_params)
      redirect_to product_path(@product)
    else
      render edit_product_feedback_path(@product)
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @feedback.destroy
    redirect_to product_path(@product)
  end

  private

  def find_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:title, :content, :product_id)
  end
end
