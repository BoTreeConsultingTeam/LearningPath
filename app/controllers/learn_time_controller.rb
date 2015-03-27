class LearnTimeController < ApplicationController
  def create
    @link = Link.find(params[:link_id])
    @link = LearnTime.create!(user_id: current_user.id, link_id: params[:link_id])

    @read_count =
    # @link.learn_time(current_user)
    redirect_to root_path
  end

  def index
    @links = current_user.learn_time
  end

  #  u.learn_time.where("created_at < ?", DateTime.now - 5.minutes)   for specific time
end
