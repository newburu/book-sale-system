class AuthorsController < InheritedResources::Base

  def index
    @q = Author.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    
    @authors = @q.result
    @authors = @authors.page(params[:page])
    @publishers = Publisher.all

    render layout: 'dialog' if params[:mode] == 'dialog'
  end

  private

    def author_params
      params.require(:author).permit(:name)
    end
end

