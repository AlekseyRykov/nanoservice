class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.references :user, foreign_key: true
      t.string :messengers
      t.string :hipchat_status
      t.string :slack_status
      t.string :telegram_status

      t.timestamps
    end
  end
end
