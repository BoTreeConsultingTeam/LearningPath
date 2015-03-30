class LearnTimeController < ApplicationController
  def create
    @link = Link.find(params[:link_id])
    @learn_time = LearnTime.create!(user_id: current_user.id, link_id: params[:link_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @links = current_user.learn_time
  end
end
