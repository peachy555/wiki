class TagWeightsController < ApplicationController
  def index
    user = User.find_by_id(session[:user_id])
    page = Page.find_by_id(params[:page_id])
    tag = Tag.find_by_id(params[:tag_id])
    # Tag weight toggler
    if TagWeight.find_by(page_id: page.id, tag_id: tag.id, user_id: user.id).nil?
      tag_weight = TagWeight.find_or_create_by(page_id: page.id, tag_id: tag.id, user_id: user.id)
    else
      tag_weight = TagWeight.find_by(page_id: page.id, tag_id: tag.id, user_id: user.id).delete
      # Delete tag where appropriete
      if tag_weight_all_pages = TagWeight.where(page_id: page.id, tag_id: tag.id).empty?
        if tag.pages.empty? # if this tag isn't attached to any other pages
          tag.destroy
        else
          page.tags.delete tag
        end
      end
    end
    redirect_to page_path(page.id)
  end
end
