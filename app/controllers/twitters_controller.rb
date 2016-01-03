# @fixme requireパスの指定
#require_relative "../../lib/twitter/twitter_accessor"
#require_relative "../../lib/twitter/twitter_util"

class TwittersController < ApplicationController

  include Twitter::TwitterUtil

  def index
    render
  end

  # GET
  def post_tweet_by_get
    # params[:tweet_text] = "Rails(Get)から投稿するテスト"
    # params[:reply_id] = "683645191547310080"
    tweet_text = params[:tweet_text]

    accessor = TwitterAccessor.new()
    accessor.login(
                   "dFvUnUTuJFI4f8qsXoNW64ZBb",
                   "dA0kcMZO4Tx5TFVFa7E9wXbSgsI2K0FnwYc9l4DUsNvJGBi88W",
                   "4667929753-7MpXsp7HjgxjQeHcW5H3l69sX3dSTtw3PSNEOMy",
                   "SUZXkAHGtqsR2othTAIbVM48MmzKyPsAovUk0Zc2srVTz"
                   )

    post_options = {}
    if params.key?(:reply_id)
      unless /^@[\w\d]* .*/ =~ tweet_text && tweet_text[0] == "@"
        abort("リプライ指定するときは「@」から初めてください\n#{tweet_text}")
      end
      post_options[:in_reply_to_status_id] = params[:reply_id]
    end

    Twitter::TwitterUtil::post(accessor, tweet_text, post_options)

    render :text => "success"
  end

end
