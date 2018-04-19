class BooksController < InheritedResources::Base

  def index
    @q = Book.ransack(params[:q])
    
    @books = @q.result
    @books = @books.page(params[:page])

    render layout: 'dialog' if params[:mode] == 'dialog'
  end

  private

    def book_params
      params.require(:book).permit(:name, :money, :sale_date, :isbn, :writer_id)
    end
end

