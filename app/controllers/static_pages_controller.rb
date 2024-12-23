class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[top form policy terms]
  def top
    @show_menu = false
  end

  def form; end

  def policy; end

  def terms; end
end
