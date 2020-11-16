module ApplicationHelper
  
  # Twitterのトップページへのリンク
  def twitter_user_link(name, id)
    link_to name, "#{Settings.system[:twitter][:url]}#{id}", target: "_blank"
  end
  
  def login?
    current_user.present?
  end

  def admin_user?
    login? && current_user.admin?
  end
  
  def check_mark(book)
    if current_user.buy?(book)
      link_to '済', buy_book_path(book.id, {user_id: current_user.id, buy_flg: false}), remote: true, class: 'btn btn-primary'
    else
      link_to '未', buy_book_path(book.id, {user_id: current_user.id, buy_flg: true }), remote: true, class: 'btn btn-secondary'
    end
  end

end
