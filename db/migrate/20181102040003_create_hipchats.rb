class CreateHipchats < ActiveRecord::Migration[5.2]
  def change
    create_table :hipchats do |t|
      t.string :title
      t.text :description
      t.string :author
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
