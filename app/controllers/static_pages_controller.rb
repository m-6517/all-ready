class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[top form policy]
  def top
    @show_menu = false
  end

  def form; end

  def policy; end
end
