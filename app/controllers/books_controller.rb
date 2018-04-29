class BooksController < InheritedResources::Base

  def index
    @q = Book.ransack(params[:q])
    @q.sorts = 'sale_date desc' if @q.sorts.empty?
    
    @books = @q.result
    @books = @books.page(params[:page])

    render layout: 'dialog' if params[:mode] == 'dialog'
  end

  private

    def book_params
      params.require(:book).permit(:name, :money, :sale_date, :isbn, :author_id)
    end
end

