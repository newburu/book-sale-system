require 'rails_helper'

RSpec.describe "writers/show", type: :view do
  before(:each) do
    @writer = assign(:writer, Writer.create!(
      :name => "Name",
      :publisher => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
