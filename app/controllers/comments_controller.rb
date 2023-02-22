class CommentsController < ApplicationController
  before_action :load_project, only: %i[destroy create]
  before_action :load_comment, only: %i[destroy]

  def create
    authorize Comment
    if current_user.comments.create!(permitted_attributes.merge(project: @project))
      redirect_to project_path(@project), notice: 'Comment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    options =
      if @comment.destroy
        { notice: "Comment was successfully destroyed." }
      else
        { alert: "Comment can not be destroyed." }
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
