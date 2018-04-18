require 'rails_helper'

RSpec.describe "writers/index", type: :view do
  before(:each) do
    assign(:writers, [
      Writer.create!(
        :name => "Name",
        :publisher => nil
      ),
      Writer.create!(
        :name => "Name",
        :publisher => nil
      )
    ])
  end

  it "renders a list of writers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
