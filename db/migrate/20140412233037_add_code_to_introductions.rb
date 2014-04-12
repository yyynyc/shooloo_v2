class AddCodeToIntroductions < ActiveRecord::Migration
  def change
    add_column :introductions, :invitation_code, :string
  end
end
