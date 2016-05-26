ActiveAdmin.register SponsorSignup do

  index do
    selectable_column
    column :contact_name
    column :contact_email
    column :company
    column :created_at
    actions
  end

  filter :name
  filter :contact_name
  filter :contact_email

end
