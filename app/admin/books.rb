ActiveAdmin.register Book do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :publication_date, :date
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :publication_date, :date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :title, :description, :price, :date, :image

  index do
    selectable_column
    id_column
    column :title
    column :price
    column :description
    column :date
    column :authors do |book|
      book.authors.map(&:name).join(", ")
    end
    column :genres do |book|
      book.genres.map(&:name).join(",")
    end
    actions
  end
  filter :title
  filter :description
  filter :date
  filter :authors, as: :select, collection: proc { Author.all }
  filter :genres, as: :select, collection: proc { Genre.all }

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :title
      f.input :price
      f.input :description
      f.input :date
      f.input :authors
      f.input :genres

      if f.object.image.attached?
        f.input :image, :as => :file, :hint => image_tag(f.object.image)
      else
        f.input :image, :as => :file
      end

    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :price
      row :description
      row :date
      row :publication_date
      row :created_at
      row :created_at
      row :authors
      row :genres
      row :image do |book|
        image_tag url_for(book.image) if book.image.attached? 
      end
    end
  end
  
end
