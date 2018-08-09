class Admin::BaseController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      if Rails.env == 'development'
        username == ENV['ADMIN_USER']
      else
        username == ENV['ADMIN_USER'] && password == ENV['ADMIN_PASSWORD']
      end
    end
  end
end
