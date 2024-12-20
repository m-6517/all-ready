class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[top form]
  def top
    @show_menu = false
  end

  def form; end
end
