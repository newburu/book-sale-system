class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :money
      t.date :sale_date
      t.string :isbn
      t.text :url
      t.text :image_url
      t.references :writer, foreign_key: true

      t.timestamps
    end
  end
end
