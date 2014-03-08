class Post < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 4000 }
end
