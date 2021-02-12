class RemoveRolesfromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :user_role, :boolean
    remove_column :users, :supervisor_role, :boolean
    remove_column :users, :superadmin_role, :boolean
    remove_column :users, :domain_name, :string
  end
end
