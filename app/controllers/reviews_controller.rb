class ReviewsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    user = User.find(session[:id])
    @review = Review.create(user_id: user.id, product_id: product.id, body: params[:review][:body], rating: params[:review][:rating])
    if @review.save
      redirect_to product_path(@product)
    else
      render :'products/show'
    end
  end
end