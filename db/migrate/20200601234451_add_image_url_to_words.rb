class AddImageUrlToWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :image_urls, :string, array: true
  end
end
