namespace :update_books do
  desc "自動でデータを更新するタスク"

  task :all_update => :environment do
    hour = Time.now.hour
    hour = 24 if hour == 0
    Book.update_all_books(hour,24)
  end

  task :update => :environment do
    Book.update_books
  end
end
