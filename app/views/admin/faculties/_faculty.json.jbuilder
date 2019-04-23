# frozen_string_literal: true

json.extract! faculty, :id, :wvu_username, :email, :last_name, :first_name, :middle_name, :created_at, :updated_at
json.url faculty_url(faculty, format: :json)
