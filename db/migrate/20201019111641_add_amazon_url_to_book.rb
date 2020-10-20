class AddAmazonUrlToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :amazon_url, :string, after: :url
  end
end
