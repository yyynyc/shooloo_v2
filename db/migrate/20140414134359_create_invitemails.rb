class CreateInvitemails < ActiveRecord::Migration
  def change
    create_table :invitemails do |t|
      t.string :to
      t.string :subject
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
