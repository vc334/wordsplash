class ChangeCompletedWordToBooleanInWords < ActiveRecord::Migration[6.0]
  def change
    remove_column :words, :completed_words
  end
end
