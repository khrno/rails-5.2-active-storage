class Admin::BaseController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      if Rails.env == 'development'
        Rails.logger.debug 'ACA'
        username == 'root'
      else
        username == 'root' && password == 'BpVmN0oS%10ioBF'
      end
    end
  end
end
