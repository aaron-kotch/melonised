class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @epoi = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @epoi_id = params[:epoiId]
    @todos = @project.todos
  end

  def new
    @project = Project.new
  end

  def create
    flash[:notice] = "Project was successfully created."
    @project = Project.new(project_params)

    if @project.save
      redirect_to project_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    flash[:notice] = "Project was successfully updated."
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    flash[:notice] = "Project was successfully destroyed."
    @project = Project.find(params[:id])
    @project.destroy!
    redirect_to projects_path, status: :see_other
  end

  private
    def project_params
      params.expect(project: [ :name ])
    end
end
