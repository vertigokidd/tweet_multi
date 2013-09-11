class User < ActiveRecord::Base
  has_many :tweets

  def tweet(text)
    tweet = tweets.create!(:text => text)
    TweetWorker.perform_async(tweet.id)
  end

  def tweet_later (text, number)
    tweet = tweets.create!(:text => text)
    TweetWorker.perform_in(number.minutes, tweet.id)
  end
end
