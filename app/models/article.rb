class Article < ApplicationRecord
  belongs_to :user

  has_many :hipchats, dependent: :destroy
  has_many :telegrams, dependent: :destroy
  has_many :slacks, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  after_commit on: :create do |m|
    article_id = m.id
    SendMessagesJob.perform_later(article_id)
  end
end
