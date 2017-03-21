class TopicsController < ApplicationController
  def index
    @user = User.find_by_id(session[:user_id])
    @topics = Topic.all
  end

  def show
    @user = User.find_by_id(session[:user_id])
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    Topic.find_or_create_by(clean_params)
    redirect_to root_path
  end

  def destroy
    topic = Topic.find(params[:id]).destroy
    flash[:success] = "You've deleted #{topic.name}."
    redirect_to root_path   #, :country_id => params[:country_id]
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(clean_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def clean_params
    params.require(:topic).permit(:name)
  end

end
