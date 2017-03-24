class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
  end

  def show
    @tags_string = ''
  end

  def create
    user = User.find_by_id(session[:user_id])
    page = Page.find(params[:page_id])
    tags_array = params[:tags_string].split(", ") # Array of tag name
    # Create tag, create association between tag and page, create tag_weight
    tags_array.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      page.tags << tag
      tag_weight = TagWeight.find_or_create_by(page_id: page.id, tag_id: tag.id, user_id: user.id)
    end
    # redirect to previous page
    redirect_to page_path page.id
  end

  def destroy
    page = Page.find(params[:page_id])
    tag = Tag.find(params[:tag_id])
    tag_weights = TagWeight.where(page_id: page.id, tag_id: tag.id)
    # Remove association between tag and page
    page.tags.delete tag
    tag_weights.each do |tag_weight|
      tag_weight.delete
    end
    # Delete tag, if tag is not attached to any page
    if tag.pages.empty?
      tag.delete
    end
    # Redirect to previous page
    redirect_to page_path page.id
  end

  private

  def clean_params
    params.require(:tag).permit(:name)
  end
end
