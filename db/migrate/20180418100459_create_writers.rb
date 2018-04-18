class CreateWriters < ActiveRecord::Migration[5.1]
  def change
    create_table :writers do |t|
      t.string :name, null: false
      t.references :publisher, foreign_key: true

      t.timestamps
    end
  end
end
