ActiveAdmin.register Medium do


  permit_params :email, :login, :password, :password_confirmation, :caption, :is_private, :user_id, :picture, :avatar, :admin_user_id

  index do
    selectable_column
    column :id
    column "picture" do |m|
      image_tag m.picture_url(:thumb)
    end
    column :caption
    column :is_private
    column :user
    column :admin_user
    actions
  end

  filter :email

  form(:html => { :multipart => true }) do |f|
    f.inputs "Media Details" do
      f.input :picture , as: :file
      f.input :caption
      f.input :is_private
      f.input :user_id, as: :select, collection: User.all.map{|m| [m.name, m.id]}
      f.input :admin_user_id, as: :select, collection: AdminUser.all.map{|m| [m.email, m.id]}
  
    end
    f.actions
  end
  
  show do |m|
    attributes_table do
      row :picture do
        image_tag m.picture_url
      end
      row :id
      row :caption
      row :is_private
      row :user
      row :created_at
      row :updated_at
      
    end
  end


end
