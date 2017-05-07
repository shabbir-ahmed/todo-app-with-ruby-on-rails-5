ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :full_name, :location, :email, :role, :status, :password, :password_confirmation
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
	menu priority: 3
	filter :full_name
  filter :email
  filter :role
	filter :status
	filter :location
	filter :created_at

	index do
		selectable_column
    	id_column
    	column :full_name
        column :email
    	column :role
    	column :location
    	column :last_sign_in_at
        column :last_sign_in_ip
    	column :status
    	column "Signup", :created_at
    	actions
  	end

  	show do
	    attributes_table do
     	 	row :full_name
            row :email
     	 	row :role
     	 	row :location
     	 	row :last_sign_in_at
            row :last_sign_in_ip
     	 	row :status
     	 	row :created_at
    	end
  	end

  	form do |f|
	    f.inputs "User Details" do
            f.input :full_name
            f.input :location
            f.input :email
            f.input :role, label: 'Role', as: :select, prompt: true, collection: [["Agent","Agent"],["None","None"]]
            if f.object.new_record?
                f.input :password
                f.input :password_confirmation
            end
            f.input :status, label: 'Status', as: :select, prompt: true, collection: [["Active","Active"],["Deactive","Deactive"]]
	    end
	    f.actions
	end

end
