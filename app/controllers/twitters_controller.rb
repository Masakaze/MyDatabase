# @fixme requireパスの指定
#require_relative "../../lib/twitter/twitter_accessor"
#require_relative "../../lib/twitter/twitter_util"

class TwittersController < ApplicationController

  include Twitter::TwitterUtil

  def index
    accessor = TwitterAccessor.new()
    accessor.login(
                   "dFvUnUTuJFI4f8qsXoNW64ZBb",
                   "dA0kcMZO4Tx5TFVFa7E9wXbSgsI2K0FnwYc9l4DUsNvJGBi88W",
                   "4667929753-7MpXsp7HjgxjQeHcW5H3l69sX3dSTtw3PSNEOMy",
                   "SUZXkAHGtqsR2othTAIbVM48MmzKyPsAovUk0Zc2srVTz"
                   )

    Twitter::TwitterUtil::post(accessor, "Railsから投稿するテスト")

    render
  end

end
