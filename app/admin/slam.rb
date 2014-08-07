ActiveAdmin.register Slam do


  permit_params :medium_first, :medium_second, :medium_first_id, :medium_second_id,
    {medium_first_attributes: [:picture, :caption, :is_private, :admin_user_id]}, 
    {medium_second_attributes: [:picture, :caption, :is_private, :admin_user_id]}

  index do |f|
    selectable_column
    column :id
    #column :picture, for: :medium_first, as: :file, hint: f.template.image_tag(f.object.medium_first.picture_url)
    #column image_tag(medium_second.picture_url)
    column :medium_first
    #column :medium_first do |m|
     # image_tag m.medium_first.picture_url(:thumb)
    #end 
    column :medium_second
    actions
  end

  filter :email

  form(:html => { :multipart => true }) do |f|
    f.inputs "Slams Details" do
      f.inputs :medium_first, for: [:medium_first, f.object.medium_first || Medium.new ] do |fm|
        fm.input :picture, for: :medium_first, as: :file#, hint: f.template.image_tag(f.object.medium_first.picture_url)          
        fm.input :caption
        fm.input :is_private, as: :hidden, value: '0'
        fm.input :admin_user_id, as: :hidden, value: current_admin_user.id
      end
      f.inputs :medium_second, for: [:medium_second, f.object.medium_second || Medium.new ] do |fm|
        fm.input :picture, for: :medium_second, as: :file#, hint: f.template.image_tag(f.object.medium_second.picture_url)
        fm.input :caption
        fm.input :is_private, as: :hidden, value: '0'
        fm.input :admin_user_id, as: :hidden, value: current_admin_user.id 
      end
    end
    f.actions
  end
  

end
