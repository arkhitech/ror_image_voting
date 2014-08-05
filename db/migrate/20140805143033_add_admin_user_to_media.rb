class AddAdminUserToMedia < ActiveRecord::Migration
  def change
    add_reference :media, :admin_user, index: true
  end
end
