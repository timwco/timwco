module Madmin
  class ApplicationController < Madmin::BaseController
    http_basic_authenticate_with(
      name: ENV['ADMIN_USERNAME'] || Rails.application.credentials.admin_username,
      password: ENV['ADMIN_PASSWORD'] || Rails.application.credentials.admin_password
    )
  end
end
