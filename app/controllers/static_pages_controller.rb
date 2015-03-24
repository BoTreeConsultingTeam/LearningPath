class StaticPagesController < ApplicationController

  def index
    @users = User.all
    @current_user = current_user
  end
end
