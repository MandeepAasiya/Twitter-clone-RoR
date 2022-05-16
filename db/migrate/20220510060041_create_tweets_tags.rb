class CreateTweetsTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags_tweets, :id => false do |t|
      t.references :tweet, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
