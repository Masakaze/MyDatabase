# @fixme requireパスの指定
#require_relative "../../lib/twitter/twitter_accessor"
#require_relative "../../lib/twitter/twitter_util"

class TwittersController < ApplicationController

  # CSRFトークンエラー対応
  protect_from_forgery with: :null_session

  include Twitter::TwitterUtil

  before_action :login_twitter, :only => ['get_home_timeline', 'post_tweet_by_get', 'post_tweet']

  def index
    render
  end

  # GET twitters/get_home_timeline.xml
  def get_home_timeline
    home_timelines = get_home_timelines(@accessor)
    result = []
    home_timelines.each { |home_timeline|
      result << {
        :id => home_timeline.id,
        :name => home_timeline.name,
        :text => home_timeline.text,
      }
    }

    respond_to do |format|
      format.xml { render :xml => result }
    end
  end

  # GET
  def post_tweet_by_get
    post_tweet_core(params)
  end

  # POST
  def post_tweet
    post_tweet_core(params)
  end

  # GET twitters/parse_by_mecab
  def parse_sentence
#    require 'rubygems'
#    require 'igo-ruby'
    ipadic_path = File.join(get_lib_dir, "twitter", "ipadic")

    # 解凍済みファイルは重いので初回のみ解凍
    if File.exist?(ipadic_path) == false
      require "zip/zip"
      Zip::ZipFile.open("#{ipadic_path}.zip") do |zip|
        zip.each do |entry|
          # { true } は展開先に同名ファイルが存在する場合に上書きする指定
          zip.extract(entry, File.join(File.dirname(ipadic_path), entry.to_s)) { true }
          end
      end
    end

    tagger = Igo::Tagger.new(ipadic_path)
    t = tagger.parse("私はサッカーが好きです")
    output = ""
    t.each { |m|
      output += "#{m.surface} #{m.feature} #{m.start}\n"
    }

    render :text => output
  end

  # GET twitters/python
  def python
    script = File.join(get_lib_dir, "python", "sample.py")
    result = `python #{script}`
    render :text => result
  end

  private
  def login_twitter
    @accessor = TwitterAccessor.new()
    @accessor.login(
                   "dFvUnUTuJFI4f8qsXoNW64ZBb",
                   "dA0kcMZO4Tx5TFVFa7E9wXbSgsI2K0FnwYc9l4DUsNvJGBi88W",
                   "4667929753-7MpXsp7HjgxjQeHcW5H3l69sX3dSTtw3PSNEOMy",
                   "SUZXkAHGtqsR2othTAIbVM48MmzKyPsAovUk0Zc2srVTz"
                   )
  end

  def post_tweet_core(params)
    # params[:tweet_text] = "Rails(Get)から投稿するテスト"
    # params[:reply_id] = "683645191547310080"
    tweet_text = params[:tweet_text]

    post_options = {}
    if params.key?(:reply_id)
      unless /^@[\w\d]* .*/ =~ tweet_text && tweet_text[0] == "@"
        abort("リプライ指定するときは「@」から初めてください\n#{tweet_text}")
      end
      post_options[:in_reply_to_status_id] = params[:reply_id]
    end

    Twitter::TwitterUtil::post(@accessor, tweet_text, post_options)

    render :text => "success"
  end

  def get_lib_dir
    return File.join(Rails.root.to_s, "lib")
  end

end
