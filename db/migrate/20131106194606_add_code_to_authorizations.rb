class AddCodeToAuthorizations < ActiveRecord::Migration
  def change
  	add_column :authorizations, :code, :string
  end
end
