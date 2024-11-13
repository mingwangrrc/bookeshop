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
  permit_params :title, :description, :date

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :date
    column :authors do |book|
      book.authors.map(&:name).join(", ")
    end
    actions
  end
  filter :title
  filter :description
  filter :date
  filter :authors, as: :select, collection: proc { Author.all }
  filter :genres, as: :select, collection: proc { Genre.all }
  
end
