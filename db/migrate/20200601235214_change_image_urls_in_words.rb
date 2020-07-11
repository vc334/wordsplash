class ChangeImageUrlsInWords < ActiveRecord::Migration[6.0]
  def change
    change_column :words, :image_urls, :string, array: true, default: []
  end
end
