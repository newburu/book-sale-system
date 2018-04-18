require 'rails_helper'

RSpec.describe "user_writers/new", type: :view do
  before(:each) do
    assign(:user_writer, UserWriter.new(
      :user => nil,
      :writer => nil
    ))
  end

  it "renders new user_writer form" do
    render

    assert_select "form[action=?][method=?]", user_writers_path, "post" do

      assert_select "input[name=?]", "user_writer[user_id]"

      assert_select "input[name=?]", "user_writer[writer_id]"
    end
  end
end
