class PortalsController < ApplicationController
  
  def index
    redirect_to mypage_path if current_user.present?
    
    Book.update_books
  end
  
  def mypage
    user_writers = current_user.user_writers.pluck(:writer_id)
    con = {writer_id_in: user_writers}
    con = con.merge(params[:q].to_unsafe_h) if params[:q].present?
    @q = Book.ransack(con)
    @q.sorts = 'sale_date asc' if @q.sorts.empty?
    
    @books = @q.result
    @books = @books.page(params[:page])
  end
  
end
