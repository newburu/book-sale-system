require 'rails_helper'

RSpec.describe "books/new", type: :view do
  before(:each) do
    assign(:book, Book.new(
      :name => "MyString",
      :money => 1,
      :isbn => 1,
      :writer => nil
    ))
  end

  it "renders new book form" do
    render

    assert_select "form[action=?][method=?]", books_path, "post" do

      assert_select "input[name=?]", "book[name]"

      assert_select "input[name=?]", "book[money]"

      assert_select "input[name=?]", "book[isbn]"

      assert_select "input[name=?]", "book[writer_id]"
    end
  end
end
