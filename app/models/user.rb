class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email, :username
  # validates :email, exclusion: { # these emails are not allowed
  #   in: ["xander@me.com", "xander@ga.com"],
  #   message: "is a forbidden email address"
  # }
  # validates :email, format: { # must follow this format to pass
  #   with: /\A.*@wdi.com\z/,
  #   message: "invalid email address"
  # }
end
