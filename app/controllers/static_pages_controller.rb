class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[top]
  def top
    @show_menu = false
  end
end
