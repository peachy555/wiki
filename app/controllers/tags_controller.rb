class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
  end

  private

  def clean_params
    params.require(:tag).permit(:name)
  end
end
