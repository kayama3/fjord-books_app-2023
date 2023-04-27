# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  before_action :set_book
  before_action :set_comment, only: %i[destroy]

  # POST /comments or /comments.json
  def create
    @comment = @book.comments.new(comment_params)
    @comment[:user_id] = current_user.id

    if @comment.save
      redirect_to [@book, @comment], notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to @book
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    redirect_to @book, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
