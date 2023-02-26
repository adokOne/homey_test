class CommentsController < ApplicationController
  before_action :load_project, only: %i[destroy create]
  before_action :load_comment, only: %i[destroy]

  def create
    authorize Comment
    if current_user.comments.create(permitted_attributes.merge(project: @project)).persisted?
      redirect_to project_path(@project), notice: t('.notice')
    else
      redirect_to project_path(@project), status: :unprocessable_entity, alert: t('.alert')
    end
  end

  def destroy
    options =
      if @comment.destroy
        { notice: t('.notice') }
      else
        { alert: t('.alert') }
      end
    redirect_to project_path(@project), **options
  end

  private

  def permitted_attributes
    params.require(:comment).permit(:text, :comment_id)
  end

  def load_comment
    @comment = @project.comments.find(params[:id])
    authorize @comment
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end
