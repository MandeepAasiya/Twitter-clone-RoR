class AddParentIdToTweets < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :parent_id, :integer, :default => nil
  end
end
