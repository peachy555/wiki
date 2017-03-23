class TagWeightsController < ApplicationController
  def index
    user = User.find_by_id(session[:user_id])
    page_id = params[:page_id]
    tag_id = params[:tag_id]
    if TagWeight.find_by(page_id: page_id, tag_id: tag_id, user_id: user.id).nil?
      tag_weight = TagWeight.find_or_create_by(page_id: page_id, tag_id: tag_id, user_id: user.id)
    else
      tag_weight = TagWeight.find_by(page_id: page_id, tag_id: tag_id, user_id: user.id).delete
    end
    redirect_to page_path(page_id)
  end


    # tag_id: 3, page_id: 7, user_id: 23

    # TagWeight.where(tag_id: 3, page_id: 7).count
    #
      # TagWeight.where(page_id: 7).group(:tag_id).count
    #
    # {"5" => 4, }


end
