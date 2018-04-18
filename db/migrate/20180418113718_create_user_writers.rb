class CreateUserWriters < ActiveRecord::Migration[5.1]
  def change
    create_table :user_writers do |t|
      t.references :user, foreign_key: true
      t.references :writer, foreign_key: true

      t.timestamps
    end
  end
end
