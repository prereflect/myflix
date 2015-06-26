class  ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.create(review_params.merge!(user: current_user))

    if review.save
      flash[:success] = 'Your review has been created'
      redirect_to @video
    else
      flash[:danger] = 'Please complete your review'
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end