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

  def destroy
    topic = Topic.find(params[:id]).destroy
    flash[:success] = "You've deleted #{topic.name}. Great work...."
    redirect_to root_path   #, :country_id => params[:country_id]
  end

end
