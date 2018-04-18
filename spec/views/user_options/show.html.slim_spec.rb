require 'rails_helper'

RSpec.describe "user_options/show", type: :view do
  before(:each) do
    @user_option = assign(:user_option, UserOption.create!(
      :user => nil,
      :dm_msg_flg => false,
      :auto_update_flg => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
