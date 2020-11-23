Trestle.resource(:projects) do
  menu do
    item :projects, icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :title
    column :description
    column :status do |proj|
      proj.status.humanize
    end
    column :featured
    actions
  end

  # Customize the form fields shown on the new/edit views.
  form do |project|
    check_box :featured, switch: true
    select :status, Project.statuses.keys.map { |status| [status.humanize, status] }
    text_field :title
    text_field :slug
    text_field :description
    text_field :started
    text_field :link
    text_area :story

  
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
