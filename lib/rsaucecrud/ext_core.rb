def app_root
    Rails.root.to_s
end

def create_html_form(form_obj, fields)

    File.open(Rails.root.to_s+'/public/form.html.erb', 'w') { |f|

        f.write '<div class="form-horizontal">' + "\n"
        f.write '    <%= form_for ' + form_obj + ' do |f| %>' + "\n"

        fields.each do |col|
            f.write '        <div class="form-group">' + "\n"
            f.write '            <label class="col-md-8">' + col.to_s + '</label>' + "\n"
            f.write '            <div class="col-md-16">' + "\n"
            f.write '                <%= f.text_field :' + col.to_s + ', {class: "form-control"} %>' + "\n"
            f.write '            </div>' + "\n"
            f.write '        </div>' + "\n"
        end

        f.write '        <div class="form-group">' + "\n"
        f.write '            <label class="col-md-8">&nbsp;</label>' + "\n"
        f.write '            <div class="col-md-16">' + "\n"
        f.write '                <button class="btn btn-primary"><i class="fa fa-save"></i> Simpan</button>' + "\n"
        f.write '                <%= link_to \'<i class="fa fa-undo"></i> Batal\'.html_safe, \'/\', {class: \'btn btn-default\'} %>' + "\n"
        f.write '            </div>' + "\n"
        f.write '        </div>' + "\n"
        f.write '    <% end %>' + "\n"
        f.write '</div>' + "\n"

    }
end

def create_html_index(fields)

    @ths = ''
    fields.each do |thx|
        @ths = @ths + '            <th>
                <%= show_th(\'' + thx.to_s + '\', \'' + thx.to_s + '\', @urlfor, @rows, @sort, @order, @filter_rules).html_safe %>
            </th>' + "\n"
    end

    @tds = ''
    fields.each do |tdx|
        @tds = @tds + '            <td class="td_filter">
                <%= show_td_filter(\'' + tdx.to_s + '\', [\'equal\', \'not equal\', \'contains\', \'l_contains\', \'less\', \'greater\']).html_safe %>
            </td>' + "\n"
    end

    @datas = ''
    fields.each do |dat|
        @datas = @datas + '            <td>
                <%= data.' + dat.to_s + ' %>
            </td>' + "\n"
    end


    File.open(Rails.root.to_s+'/public/index.html.erb', 'w') do |f|

        f.write '<table class="table table-striped">
    <thead>
        <tr>
            <th>
            </th>
' + @ths + '
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
            </td>
' + @tds + '
        </tr>
        <% @datas.each do |data| %>
        <tr>
            <td>
                <div class="btn-group">
                    <div class="btn-group">
                        <%#= link_to \'<i class="fa fa-pencil"></i>\'.html_safe, {controller: \'/provider/pdoms\', action: \'edit\', pdom_id: data.id, page: @page, rows: @rows, sort: @sort, order: @order, filter_rules: @filter_rules}, {class: \'btn btn-default btn-sm\', title: \'Edit\'} %>
                    </div>
                </div>
            </td>
' + @datas + '
        </tr>
        <% end %>
    </tbody>
</table>

<div class="col-md-24 pl0 pr0">
    <div class="btn-toolbar">

        <div class="btn-group">
            <!-- if (page - 1) = 0, don\'t show this -->
            <% if ((@page.to_i - 1) != 0) %>
            <a href="<%= @urlfor %>?page=<%= @page.to_i - 1 %>&rows=<%= @rows %>&sort=<%= @sort %>&order=<%= @order %>&filter_rules=<%= @filter_rules %>" class="btn btn-default">
                <span>&laquo;</span>
            </a>
            <% end %>

            <!-- don\'t show this if it just one page -->
            <% if @total_page.to_i > 1 %>
            <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">
               Halaman <%= @page %> <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <% @ai = 1 %>
                <% while @ai <= @total_page do %>
                <li>
                    <a href="<%= @urlfor %>?page=<%= @ai %>&rows=<%= @rows %>&sort=<%= @sort %>&order=<%= @order %>&filter_rules=<%= @filter_rules %>">
                        <%= @ai %>
                    </a>
                </li>
                <% @ai += 1 %>
                <% end %>
            </ul>
            <% end %>

            <% if ((@page.to_i + 1) < (@total_page + 1)) %>
            <a href="<%= @urlfor %>?page=<%= @page.to_i + 1 %>&rows=<%= @rows %>&sort=<%= @sort %>&order=<%= @order %>&filter_rules=<%= @filter_rules %>" class="btn btn-default">
                <span>&raquo;</span>
            </a>
            <% end %>
        </div>

        <div class="btn-group">
            <button type="button" class="btn btn-default">Data Per-halaman: <%= @rows %></button>
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="caret"></span>
                <span class="sr-only">Toggle Dropdown</span>
            </button>
            <ul class="dropdown-menu">
                <li>
                    <a href="<%= @urlfor %>?page=1&rows=5&sort=<%= @sort %>&order=<%= @order %>&filter_rules=<%= @filter_rules %>">
                        5
                    </a>
                </li>
                <li>
                    <a href="<%= @urlfor %>?page=1&rows=10&sort=<%= @sort %>&order=<%= @order %>&filter_rules=<%= @filter_rules %>">
                        10
                    </a>
                </li>
                <li>
                    <a href="<%= @urlfor %>?page=1&rows=15&sort=<%= @sort %>&order=<%= @order %>&filter_rules=<%= @filter_rules %>">
                        15
                    </a>
                </li>
                <li>
                    <a href="<%= @urlfor %>?page=1&rows=20&sort=<%= @sort %>&order=<%= @order %>&filter_rules=<%= @filter_rules %>">
                        20
                    </a>
                </li>
                <li>
                    <a href="<%= @urlfor %>?page=1&rows=30&sort=<%= @sort %>&order=<%= @order %>&filter_rules=<%= @filter_rules %>">
                        30
                    </a>
                </li>
                <li>
                    <a href="<%= @urlfor %>?page=1&rows=50&sort=<%= @sort %>&order=<%= @order %>&filter_rules=<%= @filter_rules %>">
                        50
                    </a>
                </li>
                <li>
                    <a href="<%= @urlfor %>?page=1&rows=100&sort=<%= @sort %>&order=<%= @order %>&filter_rules=<%= @filter_rules %>">
                        100
                    </a>
                </li>
            </ul>
        </div>

    </div>
</div>


<script type="text/javascript">
    var filter_rules = <%= @filter_rules.html_safe %>;

    $.each(filter_rules, function(i, nilai){
        $(\'#td_filter_\' + nilai.field + \' input\').val(nilai.value);
        $(\'#td_filter_\' + nilai.field + \' .op_info\').html(nilai.op);
    });

    function filterRulesChange(field_name, the_op) {

        // sebelum dieksekusi, diganti dulu op_info
        $(\'#td_filter_\' + field_name + \' .op_info\').html(the_op);

        var ox_filter_rules = [];
        // ambil semua parameter
        $.each($(\'.td_filter\'), function(a,b) {

            console.log($(this).find(\'input\').val());
            var ox_field = $(this).find(\'.td_field_name\').html();
            var ox_value = $(this).find(\'input\').val();
            var ox_op = $(this).find(\'.op_info\').html();

            if(ox_value != \'\' && ox_op != []) {
                ox_filter_rules.push({"field":ox_field,"op":ox_op,"value":ox_value});
            }
        });

        window.location.href = \'<%= @urlfor %>?page=1&rows=<%= @rows %>&sort=<%= @sort %>&order=<%= @order %>&filter_rules=\'+JSON.stringify(ox_filter_rules);
    }
</script>'

    end


    def create_helper_rb()
        File.open(Rails.root.to_s+'/public/helper_rb.rb', 'w') do |f|

        f.write 'module Provider::PdomsHelper

    def show_th(name, field_name, urlfor, rows, sort, order, filter_rules)

        if sort == field_name && order == \'asc\'
            @satu = \'<i class="fa fa-caret-up" style="color: #000"></i>\'
        else
            @satu = \'<i class="fa fa-caret-up"></i>\'
        end

        if sort == field_name && order == \'desc\'
            @dua = \'<i class="fa fa-caret-down" style="color: #000"></i>\'
        else
            @dua = \'<i class="fa fa-caret-down"></i>\'
        end

        \'<table class="my-table-head">
            <tr>
                <td>
                    \' + name + \'
                <td>
                <td class="pl10">
                    <table>
                        <tr>
                            <td>
                                <a href="\' + urlfor + \'?page=1&rows=\' + rows.to_s + \'&sort=\' + field_name + \'&order=asc&filter_rules=\' + filter_rules + \'" style="color: #eaeaea;">
                                    \' + @satu + \'
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="\' + urlfor + \'?page=1&rows=\' + rows.to_s + \'&sort=\' + field_name + \'&order=desc&filter_rules=\' + filter_rules + \'" style="color: #eaeaea;">
                                    \' + @dua + \'
                                </a>
                            </td>
                        </tr>
                    </table>
                <td>
            </tr>
        </table>\'
    end

    def show_td_filter(field_name, ops)

        @op_string = \'\'
        ops.each do |op|
            @op_string = @op_string + \'<li><a href="javascript: filterRulesChange(\\\'\' + field_name + \'\\\', \\\'\' + op + \'\\\');">\' + op + \'</a></li>\'
        end

        \'<div id="td_filter_\' + field_name + \'" class="input-group">
            <input type="text" class="form-control" />
            <div class="hidden td_field_name">\' + field_name + \'</div>
            <div class="input-group-btn">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="op_info">[]</span>
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu dropdown-menu-right">
                    \' + @op_string + \'
                    <li>
                        <a href="javascript: $(\\\'#td_filter_\' + field_name + \' input\\\').val(\\\'\\\'); filterRulesChange(\\\'\' + field_name + \'\\\', \\\'[]\\\');">[reset]</a>
                    </li>
                </ul>
             </div>
        </div>\'
    end
end'
        end
    end




end
