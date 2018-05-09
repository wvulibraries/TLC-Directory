json.extract! user, :id, :username, :last_name, :first_name, :middle_name, :created_at, :updated_at
json.url user_url(user, format: :json)
