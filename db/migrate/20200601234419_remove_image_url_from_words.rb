class RemoveImageUrlFromWords < ActiveRecord::Migration[6.0]
  def change
    remove_column :words, :image_url
  end
end
