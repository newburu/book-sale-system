class UserWritersController < InheritedResources::Base

  def index
    con = {user_id_eq: current_user.id}
    con = con.merge(params[:q].to_unsafe_h) if params[:q].present?
    @q = UserWriter.ransack(con)
    
    @user_writers = @q.result
    @user_writers = @user_writers.page(params[:page])
  end

  private

    def user_writer_params
      params.require(:user_writer).permit(:user_id, :writer_id)
    end
end

