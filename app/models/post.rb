class Post < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 4000 }
  validates :mood_id, presence: true
  belongs_to :user

  def self.posted
    where(deleted: false)
  end

  def self.deleted_posts
    where(deleted: true)
  end

end
