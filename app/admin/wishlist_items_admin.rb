Trestle.resource(:wishlist_items) do
  menu do
    item :wishlist_items, icon: "fa fa-star"
  end
  
  # Customize the table columns shown on the index view.
  #
  table do
    column :name
    column :url
    column :category do |wli|
      wli.category.humanize
    end
    actions
  end

  # Customize the form fields shown on the new/edit views.
  form do |wishlist_items|
    text_field :name
    text_field :url
    text_field :description  
    select :category, WishlistItem.categories.keys.map { |cat| [cat.humanize, cat] }
    row do
      col { datetime_field :updated_at }
      col { datetime_field :created_at }
    end
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:project).permit(:name, ...)
  # end
end

