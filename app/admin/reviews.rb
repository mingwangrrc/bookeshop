ActiveAdmin.register Review do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :content, :rating, :book_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:content, :rating, :book_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :content, :rating, :book_id

  index do
    selectable_column
    id_column
    column :content
    column :rating
    column :book
    actions
  end
  form do |f|
    f.inputs do
      f.input :content
      f.input :rating
      f.input :book
    end
    f.actions
  end
  
end
