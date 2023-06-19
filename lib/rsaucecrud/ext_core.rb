def rsaucecrud(the_namespace, the_controller, the_model, the_fields)
  create_controller_all(the_namespace, the_controller, the_model, the_fields)
  create_html_view(the_namespace, the_controller, the_model, the_fields)

  puts "
  resource :#{the_controller.downcase} do
    collection do
      get    '/'                => '#{the_controller.downcase}#index'
      get    'new'              => '#{the_controller.downcase}#new'
      post   'create'           => '#{the_controller.downcase}#create'
      get    ':id/edit'         => '#{the_controller.downcase}#edit'
      patch  ':id/update'       => '#{the_controller.downcase}#update'
      delete ':id/delete'       => '#{the_controller.downcase}#delete'
    end
  end
"
end
