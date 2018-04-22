json.extract! book, :id, :name, :money, :sale_date, :isbn, :author_id, :created_at, :updated_at
json.url book_url(book, format: :json)
