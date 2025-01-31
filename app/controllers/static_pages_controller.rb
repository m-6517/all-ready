class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[top form policy terms how_to_use]
  def top
    @show_menu = false
  end

  def form; end

  def policy; end

  def terms; end

  def how_to_use; end
end
