class CreateTelegrams < ActiveRecord::Migration[5.2]
  def change
    create_table :telegrams do |t|
      t.string :title
      t.text :description
      t.string :author
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
