class Page < ApplicationRecord
  belongs_to :topic
  has_and_belongs_to_many :tags, -> { distinct }
end
