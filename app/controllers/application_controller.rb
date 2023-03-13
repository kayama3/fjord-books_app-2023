# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    cookies[:locale] = :ja
    I18n.locale = cookies[:locale] || I18n.default_locale
  end
end
