class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string   "station"
      t.string   "title"
      t.string   "genre"
      t.string   "date"
      t.string   "duration"
      t.string   "description"
      t.string   "media_url"
      t.string   "origin_url"
      t.timestamps
    end
  end
end
