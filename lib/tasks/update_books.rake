namespace :update_books do
  desc "データを更新するタスク(Amazon)"
  task :all_update_by_amazon, ['page', 'total_page'] => :environment do |task, args|
    page = args[:page].to_i
    if page == 0
      page = Time.now.hour
      page = 24 if page == 0
    end
    total_page = args[:total_page].to_i
    total_page = 24 if total_page == 0
    Book.update_all_books_link_by_amazon(page, total_page)
  end

  desc "データを更新するタスク(Amazon)"
  task :update_by_amazon => :environment do
    Book.update_books_link_by_amazon
  end

  desc "データを更新するタスク(楽天)"
  task :all_update_by_rakuten, ['page', 'total_page'] => :environment do |task, args|
    page = args[:page].to_i
    if page == 0
      page = Time.now.hour
      page = 24 if page == 0
    end
    total_page = args[:total_page].to_i
    total_page = 24 if total_page == 0
    Book.update_all_books_by_rakuten(page, total_page)
  end

  desc "データを更新するタスク(楽天)"
  task :update_by_rakuten => :environment do
    Book.update_books_by_rakuten
  end
end
