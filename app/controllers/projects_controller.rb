class ProjectsController < ApplicationController

  def index 
    @title = 'Projects'
    @description = "I start things often... sometimes I finish them."
    @projects = Project.order('started ASC')
  end

  def show
    @project = Project.find_by(slug: params[:id])
    @title = @project.title
  end
  
end