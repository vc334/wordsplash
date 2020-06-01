class AddCompletedWordstoWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :completed_words, :boolean, default: false
  end
end
