ActiveAdmin.register AdminUser do
  permit_params :full_name, :email, :password, :password_confirmation

  menu priority: 2, label: 'Admin'


  index do
    selectable_column
    id_column
    column :full_name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :full_name
  filter :email
  filter :created_at

    show do
        attributes_table do
            row :full_name
            row :email
            row :last_sign_in_at
            row :last_sign_in_ip
            row :created_at
        end
    end

  form do |f|
    f.inputs "Admin Details" do
      f.input :full_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
