class LearnTimeController < ApplicationController
  def create
    @learn_time = LearnTime.create!(user_id: current_user.id, link_id: params[:link_id])
    redirect_to root_path
  end

  def index
    @links = current_user.learn_time
  end
end
