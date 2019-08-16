namespace :update_books do
  desc "自動でデータを更新するタスク(Amazon)"
  task :all_update => :environment do
    hour = Time.now.hour
    hour = 24 if hour == 0
    Book.update_all_books(hour,24)
  end

  desc "自動でデータを更新するタスク(Amazon)"
  task :update => :environment do
    Book.update_books
  end

  desc "自動でデータを更新するタスク(楽天)"
  task :all_update_by_rakuten => :environment do
    hour = Time.now.hour
    hour = 24 if hour == 0
    Book.update_all_books_by_rakuten(hour,24)
  end

  desc "自動でデータを更新するタスク(楽天)"
  task :update_by_rakuten => :environment do
    Book.update_books_by_rakuten
  end
end
