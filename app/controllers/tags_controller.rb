class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
  end

  def new
    new_page = Page.find_or_create_by(clean_params)
  end

  def create
    
  end


  private

  def clean_params
    params.require(:tag).permit(:name)
  end
end
