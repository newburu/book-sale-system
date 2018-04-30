class BooksController < InheritedResources::Base

  def index
    @q = Book.ransack(params[:q])
    @q.sorts = 'sale_date desc' if @q.sorts.empty?
    
    @books = @q.result
    @books = @books.page(params[:page])

    render layout: 'dialog' if params[:mode] == 'dialog'
  end

  # 登録後の遷移先をindexにする
  def show
    @book = Book.find_by_id(params[:id])
    # IDで見つからなかった場合は、ISBNで検索する
    @book = Book.find_by_isbn(params[:isbn]) if @book.nil?
  end

  private

    def book_params
      params.require(:book).permit(:name, :money, :sale_date, :isbn, :author_id)
    end
end

