require 'rails_helper'

RSpec.describe "user_options/index", type: :view do
  before(:each) do
    assign(:user_options, [
      UserOption.create!(
        :user => nil,
        :dm_msg_flg => false,
        :auto_update_flg => false
      ),
      UserOption.create!(
        :user => nil,
        :dm_msg_flg => false,
        :auto_update_flg => false
      )
    ])
  end

  it "renders a list of user_options" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
