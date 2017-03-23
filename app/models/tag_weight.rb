class TagWeight < ApplicationRecord
  validates_uniqueness_of :page_id, scope: [:tag_id, :user_id]
end
