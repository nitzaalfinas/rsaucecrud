def create_helper_file(the_namespace, the_controller, the_model, the_fields)

    @the_file_name = the_controller.downcase + '_helper.rb'
    dir_name = Rails.root.to_s + '/app/helpers/' + the_namespace.downcase
    FileUtils.mkdir_p dir_name

    File.open(dir_name + '/' + @the_file_name, 'w') do |f|
        f.write 'module ' + the_namespace + '::' + the_controller + 'Helper'
        f.write create_helper_text
        f.write 'end'
    end

end

def create_helper_text

'

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
'
end
