ActiveAdmin.register User do
  
     

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
    permit_params :email, :password, :password_confirmation, :role, :name, :username, :profile_picture, :description, :is_private, :current_admin_user
    
    #controller.authorize_resource
    menu if: proc{ current_admin_user.role?('superadmin') }
    
 
    index do
        selectable_column
        column :email
        column :username
        column :name
        column "profile_picture" do |m|
          image_tag m.profile_picture_url(:thumb)
        end 
        column :description
        column :is_private
        #debugger
        actions 
        #column() {|post| link_to 'Delete', :action => :destroy }
        #column() {|post| link_to 'Update', :action => :update }
    end
 
    filter :email
 
    form(:html => { :multipart => true }) do |f|
        f.inputs "User Details" do
            f.input :email
            f.input :password
            f.input :password_confirmation
            f.input :username
            f.input :name
            f.input :profile_picture, as: :file
            f.input :description
            f.input :is_private
        end
        f.actions
    end
    
  show do |m|
    attributes_table do
      row :profile_picture do
        image_tag m.profile_picture_url
      end
      row :id
      row :email
      row :name
      row :username
      row :description
      row :is_private
      row :created_at
      row :updated_at
      row :encrypted_password
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      
    end
  end
  
end
