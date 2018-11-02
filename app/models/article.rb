class Article < ApplicationRecord
  belongs_to :user

  has_many :hipchats
  has_many :telegrams
  has_many :slacks

  validates :title, presence: true
  validates :description, presence: true

  after_commit on: :create do |m|
    article_id = m.id
    SendMessagesJob.perform_later(article_id)
  end
end
