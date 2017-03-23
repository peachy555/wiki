class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    page = Page.find(params[:page_id])
    tag = Tag.find(params[:tag_id])
    tag_weights = TagWeight.where(page_id: page.id, tag_id: tag.id)

    page.tags.delete tag
    tag_weights.each do |tag_weight|
      tag_weight.delete
    end
    redirect_to page_path params[:page_id]
  end

  private

  def clean_params
    params.require(:tag).permit(:name)
  end
end
