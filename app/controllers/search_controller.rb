class SearchController < ApplicationController
  def index
    @topic_name = params[:topic]
    @tags_array = params[:tags]
    @tags_array = [] if @tags_array.nil? # no tags chosen, then params[:tags] will be nil, need to assign it with empty array so that it can be apply with .any? method
    page_list = []
    @page_list_other = []
    # Get exact search result
    if @topic_name.empty?
      pages = Page.all ### still have problem with topic name passed from side menu form "refer to _side_menu.html.erb"
      pages.each do |page|
        if @tags_array.any?
          got_all_tags = true
          @tags_array.each do |tag_name|
            # check with all tags we want in the page. If any tag is missing from the current page, trigger as false
            got_all_tags = false if !page.tags.exists? Tag.find_by(name: tag_name)
          end
          page_list << Page.find_by(id: page.id) if got_all_tags
        end
      end
    else
      # Case for search with topic and tags
      topic = Topic.find_by(name: @topic_name) # still have problem with topic name passed from side menu form "refer to _side_menu.html.erb"
      topic.pages.each do |page|
        if @tags_array.any?
          got_all_tags = true
          @tags_array.each do |tag_name|
            # check with all tags we want in the page. If any tag is missing from the current page, trigger as false
            got_all_tags = false if !page.tags.exists? Tag.find_by(name: tag_name)
            page_list << Page.find_by(id: page.id) if got_all_tags
          end
        else
          page_list << Page.find_by(id: page.id)
        end
      end
    end
    # Sorting
    # Calculate sum of score of tags used in this search for each page (more relevent the tags to page are, the higher score)
    page_score = {}
    page_list.each do |page|
      sum = 0
      tag_weight = TagWeight.where(page_id: page.id)
      @tags_array.each do |tag_name|
        tag = Tag.find_by(name: tag_name)
        ###########################################################################
        ### Problem with .group method, used to work before, no changes was made in this area
        ###########################################################################
        sum += tag_weight.group(:tag_id).count[tag.id]
      end
      # Same score as prev page?
      if page_score.key? sum
        page_score[ sum ] << page.id
      else
        page_score[ sum ] = [page.id]
      end

    end

    puts "============================ after: #{page_score}"
    # Actual sorting process
    @sorted_page_list = []
    page_score.keys.sort.reverse.each do |key|
      page_score[key].each do |page_id|
        @sorted_page_list << Page.find(page_id)
      end
    end

#-------------------------------------------------------

    # Get other search result
    if !@topic_name.empty?
      topic = Topic.find_by(name: @topic_name)
      topic.pages.each do |page|
        @page_list_other << page
      end
    end
    if !@tags_array.nil?
      @tags_array.each do |tag_name|
        Tag.find_by(name: tag_name).pages.each do |page|
          @page_list_other << page
        end
      end
    end
    @page_list_other.uniq! # Remove duplicate

    @page_list_other -= @sorted_page_list if !@sorted_page_list.empty? # Remove "exact search" results from "other search" results
  end # index
end
