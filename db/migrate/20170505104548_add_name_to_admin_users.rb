class AddNameToAdminUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :full_name, :string
  end
end
