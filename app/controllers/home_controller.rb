class HomeController < ApplicationController
  before_action :redirect_admins

  def index; end

  private

  def redirect_admins
    redirect_to avo.root_path if current_user&.admin?
  end
end
