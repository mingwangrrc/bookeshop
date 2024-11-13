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
  
  permit_params :name, :bio
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
end
