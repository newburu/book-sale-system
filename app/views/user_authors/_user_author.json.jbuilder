json.extract! user_author, :id, :user_id, :author_id, :created_at, :updated_at
json.url user_author_url(user_author, format: :json)
