authorrequire 'rails_helper'

RSpec.describe "authors/new", type: :view do
  before(:each) do
    assign(:author, Author.new(
      :name => "MyString",
      :publisher => nil
    ))
  end

  it "renders new author form" do
    render

    assert_select "form[action=?][method=?]", authors_path, "post" do

      assert_select "input[name=?]", "author[name]"

      assert_select "input[name=?]", "author[publisher_id]"
    end
  end
end
