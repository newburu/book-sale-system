namespace :update_books do
  desc "自動でデータを更新するタスク"

  task :all_update => :environment do
    Book.update_books
  end
end
