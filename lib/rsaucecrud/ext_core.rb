def rsaucecrud(the_namespace, the_controller, the_model, the_fields)
  create_controller_all(the_namespace, the_controller, the_model, the_fields)
  create_html_view(the_namespace, the_controller, the_model, the_fields)

  puts "

  # === route ===
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

  # === menu ===
            <li class=\"<%= @menu_#{the_controller.downcase} %>\">
              <a href=\"<%= url_for(controller: '/#{the_controller.downcase}', action: 'index') %>\">
                <i class=\"fa fa-user\"></i>
                <span>#{the_controller}</span>
              </a>
            </li>
"
end
