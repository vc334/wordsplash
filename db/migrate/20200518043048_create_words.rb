class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :image_url
      t.string :translation
      t.string :completed_words
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
