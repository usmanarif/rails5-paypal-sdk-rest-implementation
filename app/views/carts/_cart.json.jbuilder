json.extract! cart, :id, :purchased_at, :created_at, :updated_at
json.url cart_url(cart, format: :json)
