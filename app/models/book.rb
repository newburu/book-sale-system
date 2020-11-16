class Book < ApplicationRecord
  belongs_to :author

  def default_url
    self.amazon_url || self.url
  end

  def self.update_books_link_by_amazon
    Book.transaction do
      user_authors = UserAuthor.all.pluck(:author_id).uniq
      con = {id_in: [0] + user_authors}
      authors = Author.ransack(con).result
      authors.each do |author|
        p author
        retry_count = 0
        begin
          amazon = Paapi::Client.new(market: :jp).search_items(keywords: author.name, SearchIndex: "Books")
        rescue => e
          p e
          # 失敗した場合は、5秒待ってリトライ(５回まで)
          retry_count += 1
          if retry_count < 5
            sleep(5)
            retry
          end
        end
        (amazon.try(:items) || []).each do |item|
          book = build_amazon_item(item, author)
          # ISBNが無い場合は、セット販売等になるため、登録しない
          if book.isbn.present?
            update_book = Book.where(isbn: book.isbn).first
            p update_book
            if update_book.present?
              update_book.amazon_url = book.url
              update_book.money = book.money
              update_book.save
            end
          end
        end
        sleep(2)  # AmazonAPI制限のため、2秒待つ
      end
    end
  rescue => e
    p e
  end

  def self.update_all_books_link_by_amazon(page, total_page)
    Book.transaction do
      authors = Author.all
      per = (authors.count.fdiv(total_page)).ceil
      authors = authors.page(page).per(per)
      authors.each do |author|
        p author
        retry_count = 0
        begin
          client = Paapi::Client.new(market: :jp)
          amazon = client.search_items(keywords: author.name, SearchIndex: "Books")
          #p amazon
        rescue => e
          p e
          # 失敗した場合は、5秒待ってリトライ(５回まで)
          retry_count += 1
          if retry_count < 5
            sleep(5)
            retry
          end
        end
        (amazon.try(:items) || []).each do |item|
          book = build_amazon_item(item, author)
          # ISBNが無い場合は、セット販売等になるため、登録しない
          if book.isbn.present?
            update_book = Book.where(isbn: book.isbn).first
            if update_book.present?
              p update_book
              update_book.amazon_url = book.url
              update_book.money = book.money
              update_book.save
            end
          end
        end
        sleep(2)  # AmazonAPI制限のため、2秒待つ
      end
    end
  rescue => e
    p e
  end

  def self.build_amazon_item(item, author)
    book = Book.new
    book.name = item.title  # 商品タイトル
    book.sale_date = item.release_date  # 発売日
    book.money = ((item.get(%w{Offers Listings}) || [""])[0]).dig("Price", "Amount")  # 定価
    book.isbn = (item.get(%w{ItemInfo ExternalIds EANs DisplayValues}) || [""])[0]  # 楽天APIがEANを取得しているのでISBNとして扱う
    book.url = item.detail_url  # 詳細ページURL
    book.image_url = item.image_url  # 画像URL
    book.author = author
    
    book
  end

  def self.update_books_by_rakuten
    Book.transaction do
      user_authors = UserAuthor.all.pluck(:author_id).uniq
      con = {id_in: [0] + user_authors}
      authors = Author.ransack(con).result
      authors.each do |author|
        p author
        Book.where(author: author).delete_all
        books = []
        retry_count = 0
        begin
          rakuten = RakutenWebService::Books::Book.search(author: author.name)
        rescue => e
          p e
          # 失敗した場合は、5秒待ってリトライ(５回まで)
          retry_count += 1
          if retry_count < 5
            sleep(5)
            retry
          end
        end
        p rakuten
        rakuten.each do |item|
          book = build_rakuten_item(item, author)
          # ISBNが無い場合は、セット販売等になるため、登録しない
          # 発売日が未確定の場合も登録しない
          books << book if book.isbn.present? && book.sale_date.present?
        end
        Book.import books
        sleep(2)  # AmazonAPI制限のため、2秒待つ
      end
    end
  rescue => e
    p e
  end

  def self.update_all_books_by_rakuten(page, total_page)
    Book.transaction do
      authors = Author.all
      per = (authors.count.fdiv(total_page)).ceil
      authors = authors.page(page).per(per)
      authors.each do |author|
        p author
        Book.where(author: author).delete_all
        books = []
        retry_count = 0
        begin
          rakuten = RakutenWebService::Books::Book.search(author: author.name)
        rescue => e
          p e
          # 失敗した場合は、5秒待ってリトライ(５回まで)
          retry_count += 1
          if retry_count < 5
            sleep(5)
            retry
          end
        end
        p rakuten
        rakuten.each do |item|
          book = build_rakuten_item(item, author)
          # ISBNが無い場合は、セット販売等になるため、登録しない
          # 発売日が未確定の場合も登録しない
          books << book if book.isbn.present? && book.sale_date.present?
        end
        Book.import books
        sleep(2)  # AmazonAPI制限のため、2秒待つ
      end
    end
  rescue => e
    p e
  end

  def self.build_rakuten_item(item, author)
    p item
    book = Book.new
    book.name = item.title  # 商品タイトル
    # 発売日
    if item.sales_date =~ /\d.年\d.月\d.日/
      sales_date = item.sales_date.gsub(/[年月日]/, "")
      book.sale_date = Date.parse(sales_date)
    end
    book.money = item.list_price  # 定価
    book.isbn = item.isbn  # ISBN
    book.url = item.affiliate_url  # 詳細ページURL
    book.image_url = item.small_image_url  # 画像URL
    book.author = author
    
    book
  end

  # 更新情報をDMする
  def self.send_dm_books
    User.dm_msg_users.each do |user|
      p user
      user_authors = user.user_authors.pluck(:author_id)
      con = {author_id_in: [0] + user_authors}
      books = Book.ransack(con)
      books.sorts = 'sale_date desc'
      
      timings = Settings.system[:send_dm][:timing]
      dm_books = {}
      timings.each do |timing|
        timing_books = []
        books.result.each do |book|
          timing_books << book if (book.sale_date.present?) && ((book.sale_date - Date.today).to_i == timing.to_i)
        end
        dm_books.store(timing, timing_books)
      end
      # 結果をDM連絡
      user.send_dm_books(dm_books)
    end
  end

end
