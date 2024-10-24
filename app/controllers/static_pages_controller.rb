class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[top]
  def top; end
end
