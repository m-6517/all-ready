class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!

  def not_authenticated
    redirect_to new_user_session_path, alert: t("defaults.flash_message.require_login")
  end
end
