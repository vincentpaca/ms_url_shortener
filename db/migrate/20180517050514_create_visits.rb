class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.string :user_agent
      t.string :ip_address
      t.string :referrer
      t.integer :shortened_url_id

      t.timestamps
    end
    add_index :visits, :shortened_url_id
  end
end
