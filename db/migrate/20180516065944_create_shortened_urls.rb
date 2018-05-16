class CreateShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|
      t.string :original_url
      t.string :unique_name

      t.timestamps
    end
    add_index :shortened_urls, :unique_name
  end
end
