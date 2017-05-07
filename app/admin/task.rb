ActiveAdmin.register Task do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
# => 
	permit_params :todo, :expire, :user_id
	menu priority: 4, label: "Notes"

    scope :published, -> {where('published': true)}
    scope :notfinish, -> {where('finished': false)}
# permit_params :list, :of, :attributes, :on, :model
#
# or
    filter :user
	filter :published
	filter :finished
	filter :expire
	filter :created_at

	index do
		selectable_column
    	column :todo
        column "Due Date", :expire
    	column :published
    	column :finished
    	column "Create By", :user
    	actions
  	end

  	show do
	    attributes_table do
     	 	row :todo
            row :expire
     	 	row :published
     	 	row :finished
     	 	row :user
    	end
  	end

  	form do |f|
	    f.inputs "Task Details" do
            f.input :todo
            f.input :expire, as: :datepicker
            f.input :user
	    end
	    f.actions
	end
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
