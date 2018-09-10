json.extract! user, :id, :wvu_username, :last_name, :first_name, :middle_name, :created_at, :updated_at
json.url user_url(user, format: :json)
