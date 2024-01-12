def create_html_view(the_namespace, the_controller, the_model, the_fields)

  create_html_index(the_namespace, the_controller, the_model, the_fields)

  create_html_formnew(the_namespace, the_controller, the_model, the_fields)

  create_html_formedit(the_namespace, the_controller, the_model, the_fields)

end #create_html_view

def create_html_index(the_namespace, the_controller, the_model, the_fields)

    @the_file_name = 'index.html.erb'
    dir_name = Rails.root.to_s + '/app/views/' + the_namespace.downcase + '/' + the_controller.downcase
    FileUtils.mkdir_p dir_name

    # table head column
    @table_head_th = "
                  <th scope=\"col\"></th>"
    the_fields.each do |tdx|
      @table_head_th = "#{@table_head_th}
                  <th scope=\"col\">
                    <%= advsearch_table_th_nav('#{tdx.to_s}', '#{tdx.to_s}', 'text').html_safe %>
                  </th>"
    end
    @table_head = "<thead id=\"head_search\">
                <tr>#{@table_head_th}
                </tr>
              </thead>
"

    # Data
    @datas_td = "<td>
                      <a href=\"<%= url_for({action: 'edit', id: b.id}) %>\" class=\"btn btn-sm btn-primary\">
                        Edit
                      </a>
                      <%= link_to 'Delete', {
                          action: 'delete', id: b.id, 
                          page: @page, rows: @rows, sort: @sort, order: @order, filter_rules: @filter_rules
                        }, {
                          class: 'btn btn-default btn-sm', 
                        data: {method: 'delete', confirm: \"Are you sure?\"}
                      } %>
                    </td>
"
    the_fields.each do |dat|
      @datas_td = "#{@datas_td}
                    <td>
                      <%= b.#{dat.to_s} %>
                    </td>"
    end

    File.open(dir_name + '/' + @the_file_name, 'w') { |f|

      f.write "
<!-- TIPE GRID -->
<div class=\"content-wrapper\">
  <section class=\"content-header\">
    <h1>
      #{the_controller}
    </h1>
    <%= app_sp_breadcrumb([
      {icon: 'fa fa-dashboard', text: '', link: '/dashboard/index' },
      {icon: '', text: '#{the_controller}', link: '#' },
    ]).html_safe %>
  </section>

  <!-- Main content -->
  <section class=\"content\">
    <div class=\"row\">

      <!-- NAVIGASI HALAMAN -->
      <div class=\"col-xs-12\" style=\"margin-bottom: 0px;\">
        <table style=\"float: right\">
          <tr>
            <td style=\"padding: 0 5px;\">
              <% if @filter_rules != '[]' %>
                <%= link_to 'Reset Pencarian', {action: 'index', page: @page, rows: @rows, sort: @sort, order: @order, filter_rules: \"[]\"}, {class: ''} %>
              <% end %>
            </td>

            <td style=\"padding: 0 5px;\">
              <a href=\"<%= url_for(action: 'new') %>\" class=\"btn btn-primary\">Add New</a>
            </td>
            
            <td style=\"padding: 0 5px;\">
              <nav aria-label=\"Page navigation\">
                <ul class=\"pagination\">
                  <% if ((@page.to_i - 1) != 0) %>
                    <li>
                      <a href=\"<%= @urlfor %>?page=<%= @page.to_i - 1 %>&amp;rows=<%= @rows %>&amp;sort=<%= @sort %>&amp;order=<%= @order %>&amp;filter_rules=<%= @filter_rules %>\">
                        <span aria-hidden=\"true\">&laquo;</span>
                      </a>
                    </li>
                  <% end %>
                  <% if ((@page.to_i + 1) < (@total_page + 1)) %>
                    <li>
                      <a href=\"<%= @urlfor %>?page=<%= @page.to_i + 1 %>&amp;rows=<%= @rows %>&amp;sort=<%= @sort %>&amp;order=<%= @order %>&amp;filter_rules=<%= @filter_rules %>\">
                        <span aria-hidden=\"true\">&raquo;</span>
                      </a>
                    </li>
                  <% end %>
                </ul>
              </nav>
            </td>
            <td style=\"padding: 0 5px;\">
              <div class=\"btn-group\">
                <button type=\"button\" class=\"btn btn-default dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">
                  Baris:
                  <%= @rows %>
                </button>

                <ul class=\"dropdown-menu\">
                  <li>
                    <a href=\"<%= @urlfor %>?page=1&amp;rows=5&amp;sort=<%= @sort %>&amp;order=<%= @order %>&amp;filter_rules=<%= @filter_rules %>\">
                      5
                    </a>
                  </li>
                  <li>
                    <a href=\"<%= @urlfor %>?page=1&amp;rows=10&amp;sort=<%= @sort %>&amp;order=<%= @order %>&amp;filter_rules=<%= @filter_rules %>\">
                      10
                    </a>
                  </li>
                  <li>
                    <a href=\"<%= @urlfor %>?page=1&amp;rows=15&amp;sort=<%= @sort %>&amp;order=<%= @order %>&amp;filter_rules=<%= @filter_rules %>\">
                      15
                    </a>
                  </li>
                  <li>
                    <a href=\"<%= @urlfor %>?page=1&amp;rows=20&amp;sort=<%= @sort %>&amp;order=<%= @order %>&amp;filter_rules=<%= @filter_rules %>\">
                      20
                    </a>
                  </li>
                  <li>
                    <a href=\"<%= @urlfor %>?page=1&amp;rows=30&amp;sort=<%= @sort %>&amp;order=<%= @order %>&amp;filter_rules=<%= @filter_rules %>\">
                      30
                    </a>
                  </li>
                  <li>
                    <a href=\"<%= @urlfor %>?page=1&amp;rows=50&amp;sort=<%= @sort %>&amp;order=<%= @order %>&amp;filter_rules=<%= @filter_rules %>\">
                      50
                    </a>
                  </li>
                </ul>
              </div>
            </td>
          </tr>
        </table>
      </div>
      <!-- NAVIGASI HALAMAN -->

      <div class=\"col-xs-12\">
        <div class=\"box\">
          <!-- /.box-header -->
          <div class=\"box-body table-responsive\">

            <!-- Table grid -->
            <table class=\"table table-striped\">
              #{@table_head}
              <tbody>
                <% @datas.each do |b| %>
                  <tr>
                    #{@datas_td}
                  </tr>
                <% end %>
              </tbody>
            </table>
            <!--/ Table grid -->

          </div>
        </div>
      </div>

    </div>
  </section>
</div>

<script type=\"text/javascript\">
$(document).ready(function () {
  adding_search_head_value_for_filtering_and_go(`<%= @filter_rules.html_safe %>`);
});
</script>
      "

  }

end #create_html_index


def create_html_formnew(the_namespace, the_controller, the_model, the_fields)

    @the_file_name = 'new.html.erb'
    dir_name = Rails.root.to_s + '/app/views/' + the_namespace.downcase + '/' + the_controller.downcase
    FileUtils.mkdir_p dir_name

    File.open(dir_name + '/' + @the_file_name, 'w') { |f|

        f.write "<div class=\"content-wrapper\">\n"
        f.write "  <section class=\"content-header\">\n"
        f.write "    <h1>\n"
        f.write "      #{the_controller}\n"
        f.write "    </h1>\n"
        f.write "    <%= app_sp_breadcrumb([\n"
        f.write "      {icon: 'fa fa-dashboard', text: '', link: '/dashboard/index' },\n"
        f.write "      {icon: '', text: '#{the_controller}', link: '/#{the_controller.downcase}' },\n"
        f.write "      {icon: '', text: 'New', link: '#' },\n"
        f.write "    ]).html_safe %>\n"
        f.write "  </section>\n"
        f.write "  <!-- Main content -->\n"
        f.write "  <section class=\"content\">\n"
        f.write "    <div class=\"row\">\n"
        f.write "      <div class=\"col-xs-12\">\n"
        f.write "        <div class=\"box\">\n"
        f.write "          <div class=\"box-header with-border\">\n"
        f.write "            <h3 class=\"box-title\">New</h3>\n"
        f.write "          </div>\n"
        f.write "          <!-- /.box-header -->\n"
        f.write "          <div class=\"box-body table-responsive\">\n"
        f.write "            <%= form_for(@data, url: url_for(action: 'create')) do |f| %>\n"
        
        the_fields.each do |col|
          if col.to_s != 'id' && col.to_s != 'created_at' && col.to_s != 'updated_at'
            f.write "              <div class=\"form-group\">\n"
            f.write "                <label>#{col.to_s}</label>\n"
            f.write "                <%= f.text_field :#{col.to_s}, {class: 'form-control'} %>\n"
            f.write "              </div>\n"
          end
        end
        
        f.write "              <div class=\"form-group\">\n"
        f.write "                <%= f.submit 'Simpan', {class: 'btn btn-primary'} %>\n"
        f.write "                <a href=\"<%= url_for(action: 'index', page: params[:page], rows: params[:rows], sort: params[:sort], order: params[:order], filter_rules: params[:filter_rules]) %>\" class=\"btn btn-default\">Batal</a>\n"
        f.write "              </div>\n"
        f.write "            <% end %>\n"
        f.write "          </div>\n"
        f.write "        </div>\n"
        f.write "      </div>\n"
        f.write "    </div>\n"
        f.write "  </section>\n"
        f.write "</div>\n"
    }
end #create_html_formnew


def create_html_formedit(the_namespace, the_controller, the_model, the_fields)

    @the_file_name = 'edit.html.erb'
    dir_name = Rails.root.to_s + '/app/views/' + the_namespace.downcase + '/' + the_controller.downcase
    FileUtils.mkdir_p dir_name

    File.open(dir_name + '/' + @the_file_name, 'w') { |f|

      f.write "<div class=\"content-wrapper\">\n"
      f.write "  <section class=\"content-header\">\n"
      f.write "    <h1>\n"
      f.write "      #{the_controller}\n"
      f.write "    </h1>\n"
      f.write "    <%= app_sp_breadcrumb([\n"
      f.write "      {icon: 'fa fa-dashboard', text: '', link: '/dashboard/index' },\n"
      f.write "      {icon: '', text: '#{the_controller}', link: '/#{the_controller.downcase}' },\n"
      f.write "      {icon: '', text: 'Edit', link: '#' },\n"
      f.write "    ]).html_safe %>\n"
      f.write "  </section>\n"
      f.write "  <!-- Main content -->\n"
      f.write "  <section class=\"content\">\n"
      f.write "    <div class=\"row\">\n"
      f.write "      <div class=\"col-xs-12\">\n"
      f.write "        <div class=\"box\">\n"
      f.write "          <div class=\"box-header with-border\">\n"
      f.write "            <h3 class=\"box-title\">Edit</h3>\n"
      f.write "          </div>\n"
      f.write "          <!-- /.box-header -->\n"
      f.write "          <div class=\"box-body table-responsive\">\n"
      f.write "            <%= form_for(@data, url: url_for(action: 'update', id: @data.id, page: params[:page], rows: params[:rows], sort: params[:sort], order: params[:order], filter_rules: params[:filter_rules])) do |f| %>\n"
      
      the_fields.each do |col|
        if col.to_s != 'id' && col.to_s != 'created_at' && col.to_s != 'updated_at'
          f.write "              <div class=\"form-group\">\n"
          f.write "                <label>#{col.to_s}</label>\n"
          f.write "                <%= f.text_field :#{col.to_s}, {class: 'form-control'} %>\n"
          f.write "              </div>\n"
        end
      end
      
      f.write "              <div class=\"form-group\">\n"
      f.write "                <%= f.submit 'Simpan', {class: 'btn btn-primary'} %>\n"
      f.write "                <a href=\"<%= url_for(action: 'index', page: params[:page], rows: params[:rows], sort: params[:sort], order: params[:order], filter_rules: params[:filter_rules]) %>\" class=\"btn btn-default\">Batal</a>\n"
      f.write "              </div>\n"
      f.write "            <% end %>\n"
      f.write "          </div>\n"
      f.write "        </div>\n"
      f.write "      </div>\n"
      f.write "    </div>\n"
      f.write "  </section>\n"
      f.write "</div>\n"
    }
end #create_html_formedit
