class FavouritesController < ApplicationController
  before_filter :current_link, only: [:toggle]

  def toggle
    if @link.favourite
      @link.update_attribute(:favourite, false)
    else
      @link.update_attribute(:favourite, true)
    end
    respond_to do |format|
      format.js
    end
  end

  private
    def current_link
      @link = Link.find(params[:id])
    end
end
