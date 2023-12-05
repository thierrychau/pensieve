class ChangeUrlToMediaUrlInMedia < ActiveRecord::Migration[7.0]
  def change
    rename_column :media, :url, :media_url
  end
end
