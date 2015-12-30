class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]

  respond_to :html

  def edit
    @place = @review.place
  end

  def create
    @review = current_user.reviews.new(review_params)

    respond_to do |format|
      if @review.save
       
        
        format.html { redirect_to place_path(@review.place), notice: "Review created" }

      else
        redirect_to place_path(@review.place), notice: "Something went wrong"
      end
    end
  end
  
  def update
    @review.update(review_params)
    respond_with(@review)
  end

  def destroy
    @review.destroy
    respond_with(@review)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:place_id, :content)
    end
end