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
  permit_params :title, :description, :date, :images

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :date
    column :authors do |book|
      book.authors.map(&:name).join(", ")
    end
    column :genres do |genre|
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
      f.input :description
      f.input :date
      f.input :authors
      f.input :genres

      f.inputs do
        f.input :images, as: :file, input_html: { multiple: true }
      end

    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :date
      row :publication_date
      row :created_at
      row :created_at
      row :authors
      row :genres
      row :images do |book|
        ul do
          book.images.each do |img|
            li do
              image_tag url_for(img)
              # image_tag(img.picture.url(:thumb))
            end
          end
         end

        # image_tag url_for(book.images)
        # for image in book.images
        #   image_tag url_for(image)
        # end
      end
    end
  end
  
end
