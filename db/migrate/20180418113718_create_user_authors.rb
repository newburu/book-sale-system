class CreateUserAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :user_authors do |t|
      t.references :user, foreign_key: true
      t.references :author, foreign_key: true

      t.timestamps
    end
  end
end
