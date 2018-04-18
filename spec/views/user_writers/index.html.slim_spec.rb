require 'rails_helper'

RSpec.describe "user_writers/index", type: :view do
  before(:each) do
    assign(:user_writers, [
      UserWriter.create!(
        :user => nil,
        :writer => nil
      ),
      UserWriter.create!(
        :user => nil,
        :writer => nil
      )
    ])
  end

  it "renders a list of user_writers" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
