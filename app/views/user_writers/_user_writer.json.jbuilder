json.extract! user_writer, :id, :user_id, :writer_id, :created_at, :updated_at
json.url user_writer_url(user_writer, format: :json)
