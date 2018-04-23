class PortalsController < ApplicationController
  
  def index
    redirect_to mypage_path if current_user.present?
  end
  
  def mypage
    # ログインしていなければ、TOPページに移動
    redirect_to root_url and return unless current_user.present?

    user_authors = current_user.user_authors.pluck(:author_id)
    con = {author_id_in: user_authors}
    con = con.merge(params[:q].to_unsafe_h) if params[:q].present?
    @q = Book.ransack(con)
    @q.sorts = 'sale_date desc' if @q.sorts.empty?
    
    @books = @q.result
    @books = @books.page(params[:page])
  end
  
end
