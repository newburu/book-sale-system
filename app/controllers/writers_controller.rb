class WritersController < InheritedResources::Base

  def index
    @q = Writer.ransack(params[:q])
    
    @writers = @q.result
    @writers = @writers.page(params[:page])
    @publishers = Publisher.all

    render layout: 'dialog' if params[:mode] == 'dialog'
  end

  private

    def writer_params
      params.require(:writer).permit(:name, :publisher_id)
    end
end

