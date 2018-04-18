require 'rails_helper'

RSpec.describe "user_writers/edit", type: :view do
  before(:each) do
    @user_writer = assign(:user_writer, UserWriter.create!(
      :user => nil,
      :writer => nil
    ))
  end

  it "renders the edit user_writer form" do
    render

    assert_select "form[action=?][method=?]", user_writer_path(@user_writer), "post" do

      assert_select "input[name=?]", "user_writer[user_id]"

      assert_select "input[name=?]", "user_writer[writer_id]"
    end
  end
end
