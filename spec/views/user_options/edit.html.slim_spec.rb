require 'rails_helper'

RSpec.describe "user_options/edit", type: :view do
  before(:each) do
    @user_option = assign(:user_option, UserOption.create!(
      :user => nil,
      :dm_msg_flg => false,
      :auto_update_flg => false
    ))
  end

  it "renders the edit user_option form" do
    render

    assert_select "form[action=?][method=?]", user_option_path(@user_option), "post" do

      assert_select "input[name=?]", "user_option[user_id]"

      assert_select "input[name=?]", "user_option[dm_msg_flg]"

      assert_select "input[name=?]", "user_option[auto_update_flg]"
    end
  end
end
