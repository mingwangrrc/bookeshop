ActiveAdmin.register Author do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :bio
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :bio]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :name, :bio, :profile_picture
  index do
    selectable_column
    id_column
    column :name
    column :bio
    column :books do |author|
      author.books.map(&:title).join(", ")
    end
    actions
  end
  filter :name
  filter :bio
  filter :books, as: :select, collection: proc { Book.all }

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :bio

      if f.object.profile_picture.attached?
        f.input :profile_picture, :as => :file, :hint => image_tag(f.object.profile_picture)
      else
        f.input :profile_picture, :as => :file
      end
      # f.input :profile_picture, :as => :file, :hint => f.template.image_tag(f.object.profile_picture.url(:medium))
    end
    f.actions
  end

  # form partial: 'form'

  show do
    attributes_table do
      row :name
      row :bio
      row :created_at
      row :updated_at
      row :profile_picture do |author|
        image_tag url_for(author.profile_picture) if author.profile_picture.attached? 
      end
    end
  end

end
