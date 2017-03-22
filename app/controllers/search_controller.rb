class SearchController < ApplicationController
  def index
    @topic_name = params[:topic]
    @tags_array = params[:tags]
    @page_list = []
    @page_list_other = []
    # Get exact search result
    if @topic_name.empty?
      pages = Page.all ### still have problem with topic name passed from side menu form "refer to _side_menu.html.erb"
      pages.each do |page|
        if !@tags_array.nil?
          got_all_tags = true
          @tags_array.each do |tag_name|
            # check with all tags we want in the page. If any tag is missing from the current page, trigger as false
            got_all_tags = false if !page.tags.exists? Tag.find_by(name: tag_name)
          end
          @page_list << Page.find_by(id: page.id) if got_all_tags
        end
      end
    else
      topic = Topic.find_by(name: @topic_name) # still have problem with topic name passed from side menu form "refer to _side_menu.html.erb"
      topic.pages.each do |page|
        if !@tags_array.nil?
          got_all_tags = true
          @tags_array.each do |tag_name|
            # check with all tags we want in the page. If any tag is missing from the current page, trigger as false
            got_all_tags = false if !page.tags.exists? Tag.find_by(name: tag_name)
            @page_list << Page.find_by(id: page.id) if got_all_tags
          end
        else
          @page_list << Page.find_by(id: page.id)
        end
      end
    end

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

    @page_list_other -= @page_list if !@page_list.empty? # Remove "exact search" results from "other search" results
  end # index
end
