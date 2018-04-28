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
        sleep(2)  # AmazonAPI制限のため、2秒待つ
      end
    end
  rescue => e
    p e.message
  end

  # 更新情報をDMする
  def self.send_dm_books
    User.dm_msg_users.each do |user|
      user_authors = user.user_authors.pluck(:author_id)
      con = {author_id_in: user_authors}
      books = Book.ransack(con)
      books.sorts = 'sale_date desc'
      
      timings = Settings.system[:send_dm][:timing]
      dm_books = {}
      timings.each do |timing|
        timing_books = []
        books.result.each do |book|
          timing_books << book if (book.sale_date - Date.today).to_i == timing.to_i
        end
        dm_books.store(timing, timing_books)
      end
      # 結果をDM連絡
      user.send_dm_books(dm_books)
    end
  end

end
