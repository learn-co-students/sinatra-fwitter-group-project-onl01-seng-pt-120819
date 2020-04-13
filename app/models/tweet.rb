class Tweet < ActiveRecord::Base
  belongs_to :user
  # validates :content, presence: true => does not allows a tweet to be created if it has not content
end
