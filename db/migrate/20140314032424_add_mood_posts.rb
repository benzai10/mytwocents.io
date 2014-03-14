class AddMoodPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :mood_id, :integer, :default => 50
  end

  def self.down
    remove_column :posts, :mood_id
  end
end
