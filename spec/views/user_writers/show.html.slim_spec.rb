require 'rails_helper'

RSpec.describe "user_writers/show", type: :view do
  before(:each) do
    @user_writer = assign(:user_writer, UserWriter.create!(
      :user => nil,
      :writer => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
