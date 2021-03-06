class User < ApplicationRecord
  devise :trackable, :omniauthable
  
  # 設定
  has_one :option, :class_name => "UserOption"
  accepts_nested_attributes_for :option
  
  # 好きな作家
  has_many :user_authors

  # 本
  has_many :user_books

  validates :name, presence: true

  #############
  # スコープ
  scope :auto_update_users, -> {includes(:option).where(user_options: {auto_update_flg: true})}
  scope :dm_msg_users, -> {includes(:option).where(user_options: {dm_msg_flg: true})}

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name: auth.info.name,
                         screen_name: auth.info.nickname,
                          provider: auth.provider,
                          uid: auth.uid,
#                          email:auth.extra.user_hash.email, #色々頑張りましたがtwitterではemail取得できません
                          password: Devise.friendly_token[0,20],
                          access_token: auth.credentials.token,
                          access_token_secret: auth.credentials.secret
                          )
    else
      user.update(access_token: auth.credentials.token,access_token_secret: auth.credentials.secret)
    end
    user
  end

  # 更新情報をDMする
  def send_dm_books(dm_books)
    send_flg = false
    msg = "##{Settings.system[:title]} よりお知らせ\r\n\r\n"
    dm_books.each do |key, books|
      if key == 0
        msg += "◆本日発売！\r\n"
      else
        msg += "◆発売#{key}日前\r\n"
      end
      if books.blank?
        msg += "なし\r\n"
      else
        send_flg = true
      end
      books.each do |book|
        msg += "#{book.name}(ISBN:#{book.isbn})\r\n"
      end
    end
    msg += "\r\n詳細はログインしてご確認ください。\r\n#{Settings.system[:url]}"

    if send_flg
      p "======="
      p "#{name}(#{screen_name})"
      p "======="
      p msg
      twitter_client.create_direct_message(uid, msg)
    end
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_SECRET_KEY"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def buy?(book)
    self.user_books.find_by(user_id: self.id, isbn: book.isbn).try(:buy?)
  end

end
