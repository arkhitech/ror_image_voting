ActiveAdmin.register AdminUser do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
    permit_params :email, :password, :password_confirmation, :role
    
    #controller.authorize_resource
 
    index do
        selectable_column
        column :email
        column :current_sign_in_at
        column :last_sign_in_at
        column :sign_in_count
        column :role
        #debugger
        actions 
        #column() {|post| link_to 'Delete', :action => :destroy }
        #column() {|post| link_to 'Update', :action => :update }
    end
 
    filter :email
 
    form do |f|
        f.inputs "User Details" do
            f.input :email
            f.input :password
            f.input :password_confirmation
            f.input :role, as: :radio, collection: {Advertiser: "advertiser", SuperAdmin: "superadmin"}
        end
        f.actions
    end
  
end
