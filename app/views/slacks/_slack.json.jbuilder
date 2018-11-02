json.extract! slack, :id, :title, :description, :author, :article_id, :created_at, :updated_at
json.url slack_url(slack, format: :json)
