class TopicsController < ApplicationController
  def index
    @user = User.find_by_id(session[:user_id])
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    Topic.find_or_create_by(name: params[:topic][:name])
    redirect_to root_path
  end

end
