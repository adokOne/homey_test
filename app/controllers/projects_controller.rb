class ProjectsController < ApplicationController
  before_action :load_project, except: %i[new create index]

  def index
    authorize Project
    @projects = Project.page(params[:page]).per(10)
  end

  def new
    authorize Project
    @project = Project.new(user: current_user)
  end

  def edit;end
  def show;end

  def create
    authorize Project
    if current_user.projects.create(permitted_attributes)
      redirect_to projects_path, notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(permitted_attributes)
      redirect_to projects_path, notice: 'Project was successfully created.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def change_status
    if @project.change_status!(current_user, params[:status].to_i)
      redirect_to project_path(@project), notice: 'Project was successfully created.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    options =
      if @project.destroy
        { notice: "Project was successfully destroyed." }
      else
        { alert: "Project can not be destroyed." }
      end
    redirect_to projects_path, **options
  end

  private

  def permitted_attributes
    params.require(:project).permit(:name, :description)
  end

  def load_project
    @project = Project.find(params[:id])
    authorize @project
  end
end
