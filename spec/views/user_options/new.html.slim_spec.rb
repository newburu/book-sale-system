require 'rails_helper'

RSpec.describe "user_options/new", type: :view do
  before(:each) do
    assign(:user_option, UserOption.new(
      :user => nil,
      :dm_msg_flg => false,
      :auto_update_flg => false
    ))
  end

  it "renders new user_option form" do
    render

    assert_select "form[action=?][method=?]", user_options_path, "post" do

      assert_select "input[name=?]", "user_option[user_id]"

      assert_select "input[name=?]", "user_option[dm_msg_flg]"

      assert_select "input[name=?]", "user_option[auto_update_flg]"
    end
  end
end
