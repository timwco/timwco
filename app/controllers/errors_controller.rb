class ErrorsController < ApplicationController
  def not_found
    @title       = "404"
    @description = "404: Page Not Found"    
    render(:status => 404)
  end

  def internal_server_error
    @title       = "500"
    @description = "500: Server Error"     
    render(:status => 500)
  end
end