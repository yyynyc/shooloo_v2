class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text   :description
      t.text   :content
      t.string :player_loc
      t.string :duration
      t.string :length
      t.string :tags
      t.integer :category_id
      t.integer :practice_id
      t.integer :standard_id
      t.attachment :thumbnail
      t.boolean :teacher_pd, default: false

      t.timestamps
    end
  end
end
