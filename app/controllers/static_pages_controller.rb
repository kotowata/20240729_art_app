class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top privacy_policy terms]

  def top; end

  def privacy_policy; end

  def terms; end

end
