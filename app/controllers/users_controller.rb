# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit]

  def index
    @users = User.with_attached_icon.order(:id).page(params[:page])
  end

  def show; end

  def edit; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
