class PagesController < ApplicationController

  def show
    @page = Page.find(params[:id])
    @topic_id = params[:topic_id]
    @user = User.find_by_id(session[:user_id])
  end

  def new
    @topic_id = params[:topic_id]
    @page = Page.new
  end

  def create
    Page.find_or_create_by(name: params[:page][:name])
    redirect_to root_path
  end
end
