class PublishersController < InheritedResources::Base

  def index
    @q = Publisher.ransack(params[:q])
    
    @publishers = @q.result
    @publishers = @publishers.page(params[:page])
  end

  private

    def publisher_params
      params.require(:publisher).permit(:name)
    end
end

