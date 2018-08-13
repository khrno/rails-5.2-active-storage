class Admin::DashboardController < Admin::BaseController
  skip_before_action :current_tab

  def index
  end
end