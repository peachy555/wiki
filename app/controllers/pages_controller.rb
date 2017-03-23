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
    @topic_id = params[:topic_id]
    # Create new page
    page_params = clean_params
    page_params[:topic_id] = @topic_id
    new_page = Page.find_or_create_by(page_params)
    # Attach tags to the page
    tags_string = params[:tags_string]
    tags_array = tags_string.split(", ")
    tags_array.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      new_page.tags << tag
    end
    binding.pry
    # End of pages#create
    redirect_to topic_path(@topic_id)
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:success] = "You've deleted #{page.name}."
    redirect_to topic_path(params[:topic_id])   #, :country_id => params[:country_id]
  end

  def edit
    @topic_id = params[:topic_id]
    @page = Page.find(params[:id])
    @tags_string = ''
    @page.tags.each do |tag|
      @tags_string += (tag.name + ", ")
    end
    @tags_string = @tags_string.chomp(", ")
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(clean_params)
      tags_string = params[:tags_string]
      tags_array = tags_string.split(", ")
      tags_array.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        if !@page.tags.exists? tag # if the tag doesn't exist in the list
          @page.tags << tag
        end
      end
      redirect_to topic_path(params[:topic_id])
    else
      render :edit
    end
  end

  private

  def clean_params
    params.require(:page).permit(:name, :free_content, :member_content, :tags_string)
  end
end
