class Book < ApplicationRecord
  belongs_to :writer

  def self.update_books
    Book.delete_all
    writers = Writer.all
    writers.each do |writer|
      books = []
      amazon = Amazon::Ecs.item_search(writer.name, :response_group => 'Images,ItemAttributes,OfferSummary', :search_index => 'Books', :country => 'jp')
      amazon.items.each do |item|
        book = Book.new
        book.name = item.get("ItemAttributes/Title")  # 商品タイトル
        book.sale_date = item.get("ItemAttributes/PublicationDate")  # 発売日
        book.money = item.get("OfferSummary/LowestNewPrice/Amount")  # 定価
        book.isbn = item.get("ItemAttributes/ISBN")  # ISBN
        book.url = item.get("DetailPageURL")  # 詳細ページURL
        book.image_url = item.get("ImageSets/ImageSet/ThumbnailImage/URL")  # 画像URL
        book.writer = writer
        
        # ISBNが無い場合は、セット販売等になるため、登録しない
        books << book if book.isbn.present?
      end
      Book.import books
    end
  end

end
