class AddRoleToAdminUsers < ActiveRecord::Migration
    def change
        add_column :admin_users, :role, :string
 
        AdminUser.create! do |u|
            u.email     = 'admin@example.com'
            u.password    = 'admin123'
            u.role = 'superadmin'
        end
    end
end

