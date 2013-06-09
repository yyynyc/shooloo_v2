class CreateInvites < ActiveRecord::Migration
  def up
    create_table :invites do |t|
      t.integer :inviter_id
      t.integer :post_id

      t.timestamps
    end
  end

  def down
    drop_table :invites
  end
end
