namespace :update_infos do
  desc "更新情報タスク"

  task :send_dm_books => :environment do
    Book.send_dm_books
  end
end
