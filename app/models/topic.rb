class Topic < ApplicationRecord
  has_many :pages
  validates_uniqueness_of :name
end
