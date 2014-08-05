ActiveAdmin.register Slam do


  permit_params :media_first_id, :media_second_id, :current_admin_user, 
    {media_first_attributes: [:picture, :caption, :is_private]}, {media_second_attributes: [:picture, :caption, :is_private]}

  index do |f|
    selectable_column
    column :id
    #column :picture, for: :media_first, as: :file, hint: f.template.image_tag(f.object.media_first.picture_url)
    #column image_tag(media_second.picture_url)
    column :media_first
    #column :media_first do |m|
     # image_tag m.media_first.picture_url(:thumb)
    #end 
    column :media_second
    actions
  end

  filter :email

  form(:html => { :multipart => true }) do |f|
    f.inputs "Slams Details" do
      f.inputs :media_first, for: [:media_first, f.object.media_first || Media.new ] do |fm|
        fm.input :picture, for: :media_first, as: :file#, hint: f.template.image_tag(f.object.media_first.picture_url)          
        fm.input :caption
        fm.input :is_private, as: :hidden, value: '0'
        fm.input :admin_user, as: :hidden, value: proc { current_admin_user.id }
      end
      f.inputs :media_second, for: [:media_second, f.object.media_second || Media.new ] do |fm|
        fm.input :picture, for: :media_second, as: :file#, hint: f.template.image_tag(f.object.media_second.picture_url)
        fm.input :caption
        fm.input :is_private, as: :hidden, value: '0'
        fm.input :admin_user, as: :hidden, value: proc { current_admin_user.id }
      end
    end
    f.actions
  end
  

end
