require 'rails_helper'

RSpec.describe "writers/new", type: :view do
  before(:each) do
    assign(:writer, Writer.new(
      :name => "MyString",
      :publisher => nil
    ))
  end

  it "renders new writer form" do
    render

    assert_select "form[action=?][method=?]", writers_path, "post" do

      assert_select "input[name=?]", "writer[name]"

      assert_select "input[name=?]", "writer[publisher_id]"
    end
  end
end
