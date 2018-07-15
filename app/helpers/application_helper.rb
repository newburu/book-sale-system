module ApplicationHelper
  
  # Twitterのトップページへのリンク
  def twitter_user_link(name, id)
    link_to name, "#{Settings.system[:twitter][:url]}#{id}", target: "_blank"
  end
  
  def login?
    current_user.present?
  end
  
end
