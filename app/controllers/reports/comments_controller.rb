class Reports::CommentsController < ApplicationController
  before_action :set_report
  before_action :set_comment, only: %i[ destroy ]

  # POST /comments or /comments.json
  def create
    @comment = @report.comments.new(comment_params)
    @comment[:user_id] = current_user.id

    if @comment.save
      redirect_to [@report, @comment], notice: "Comment was successfully created."
    else
      redirect_to @report
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    redirect_to @report, notice: "Comment was successfully destroyed."
  end

  private
    def set_report
      @report = Report.find(params[:report_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
