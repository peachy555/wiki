class Page < ApplicationRecord
  validates_uniqueness_of :name
  belongs_to :topic
  has_and_belongs_to_many :tags, -> { distinct }
end
