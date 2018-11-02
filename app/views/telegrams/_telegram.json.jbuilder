json.extract! telegram, :id, :title, :description, :author, :article_id, :created_at, :updated_at
json.url telegram_url(telegram, format: :json)
