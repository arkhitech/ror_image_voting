ActiveAdmin.register GroupShare do


  permit_params :group, :media, {group_attribtues: []}, {media_attributes: []}

  index do
    selectable_column
    column :id
    column :group
    column :media
    actions
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "Group Share Details" do
      f.input :user_group_id, as: :select, collection: UserGroup.all.map{|m| [m.group_name, m.id]}
      f.input :medium_id, as: :select, collection: Medium.all.map{|m| [m.caption, m.id]}#, hint: f.template.image_tag(f.object.media.picture_url) 
    end
    f.actions
  end


end
