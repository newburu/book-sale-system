class UserAuthorsController < InheritedResources::Base

  def index
    con = {user_id_eq: current_user.id}
    con = con.merge(params[:q].to_unsafe_h) if params[:q].present?
    @q = UserAuthor.ransack(con)
    
    @user_authors = @q.result
    @user_authors = @user_authors.page(params[:page])
  end

  # 登録後の遷移先をindexにする
  def create
    create! { user_authors_path }
  end

  private

    def user_author_params
      params.require(:user_author).permit(:user_id, :author_id)
    end
end

