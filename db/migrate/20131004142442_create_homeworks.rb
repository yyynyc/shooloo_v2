class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.integer :week
      t.integer :year
      t.integer :user_id
      t.integer :post_count
      t.integer :comment_count

      t.timestamps
    end
  end
end
