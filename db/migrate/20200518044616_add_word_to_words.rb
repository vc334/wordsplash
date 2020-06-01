class AddWordToWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :word, :string
  end
end
