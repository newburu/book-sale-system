class UserWritersController < InheritedResources::Base

  def index
    @q = UserWriter.ransack(params[:q])
    
    @user_writers = @q.result
    @user_writers = @user_writers.page(params[:page])
  end

  private

    def user_writer_params
      params.require(:user_writer).permit(:user_id, :writer_id)
    end
end

