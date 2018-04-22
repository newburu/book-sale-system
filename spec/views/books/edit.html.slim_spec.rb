authorrequire 'rails_helper'

RSpec.describe "books/edit", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :name => "MyString",
      :money => 1,
      :isbn => 1,
      :author => nil
    ))
  end

  it "renders the edit book form" do
    render

    assert_select "form[action=?][method=?]", book_path(@book), "post" do

      assert_select "input[name=?]", "book[name]"

      assert_select "input[name=?]", "book[money]"

      assert_select "input[name=?]", "book[isbn]"

      assert_select "input[name=?]", "book[author_id]"
    end
  end
end
