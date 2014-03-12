class Post < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 4000 }

  def self.posted
    where(deleted: false)
  end

  def self.deleted
    where(deleted: true)
  end

end
