def rsaucecrud(the_namespace, the_controller, the_model, the_fields)
  create_controller_all(the_namespace, the_controller, the_model, the_fields)
  create_html_view(the_namespace, the_controller, the_model, the_fields)
end
