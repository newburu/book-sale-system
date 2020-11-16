class CreateUserBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_books do |t|
      t.references :user, foreign_key: true
      t.string :isbn, null: false
      t.boolean :buy

      t.timestamps
    end
  end
end
