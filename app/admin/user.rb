ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
	filter :full_name
	filter :email
	filter :location
	filter :created_at

	index do
		selectable_column
    	id_column
    	column :full_name
    	column :email
    	column :location
    	column :last_sign_in_at
    	column :last_sign_in_ip
    	column "Signup", :created_at
    	actions
  	end

  	show do
	    attributes_table do
     	 	row :full_name
     	 	row :email
     	 	row :location
     	 	row :last_sign_in_at
     	 	row :last_sign_in_ip
     	 	row :created_at
    	end
  	end

  	form do |f|
	    f.inputs "User Details" do
	      f.input :full_name
	      f.input :location
	      f.input :email
	      f.input :password
	      f.input :password_confirmation
	    end
	    f.actions
	end

end
