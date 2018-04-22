class Book < ApplicationRecord
  belongs_to :author

  def self.update_books
    Book.transaction do
      Book.delete_all
      user_authors = UserAuthor.all.pluck(:author_id).uniq
      con = {id_in: user_authors}
      authors = Author.ransack(con).result
      authors.each do |author|
        books = []
        amazon = Amazon::Ecs.item_search(author.name, :response_group => 'Images,ItemAttributes,OfferSummary', :search_index => 'Books', :country => 'jp')
        amazon.items.each do |item|
          book = Book.new
          book.name = item.get("ItemAttributes/Title")  # 商品タイトル
          book.sale_date = item.get("ItemAttributes/PublicationDate")  # 発売日
          book.money = item.get("OfferSummary/LowestNewPrice/Amount")  # 定価
          book.isbn = item.get("ItemAttributes/ISBN")  # ISBN
          book.url = item.get("DetailPageURL")  # 詳細ページURL
          book.image_url = item.get("SmallImage/URL")  # 画像URL
          book.author = author
          
          # ISBNが無い場合は、セット販売等になるため、登録しない
          books << book if book.isbn.present?
        end
        Book.import books
      end
    end
  rescue => e
    p e.message
  end

end
