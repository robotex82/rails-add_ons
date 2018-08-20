class Post < ActiveRecord::Base
  belongs_to :user

  attr_accessible :body, :published_at, :title
end
