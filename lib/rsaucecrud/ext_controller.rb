def create_controller_all(the_namespace, the_controller, the_model, the_fields)

    @the_file_name = the_controller.downcase + '_controller.rb'

    dir_name = Rails.root.to_s + '/app/controllers/' + the_namespace.downcase
    FileUtils.mkdir_p dir_name

    File.open(dir_name + '/' + @the_file_name, 'w') do |f|

        f.write 'class ' + the_namespace + '::' + the_controller + 'Controller < ApplicationController'

        f.write create_controller_index(the_namespace, the_controller, the_model, the_fields)

        f.write create_controller_new(the_namespace, the_controller, the_model, the_fields)

        f.write create_controller_create(the_namespace, the_controller, the_model, the_fields)

        f.write create_controller_show(the_namespace, the_controller, the_model, the_fields)

        f.write create_controller_edit(the_namespace, the_controller, the_model, the_fields)

        f.write create_controller_update(the_namespace, the_controller, the_model, the_fields)

        f.write create_controller_destroy(the_namespace, the_controller, the_model, the_fields)

        f.write "\n" + 'end'
    end

end


def create_controller_index(the_namespace, the_controller, the_model, the_fields)

"

    def index
        if params[:page]
            @page = params[:page].to_i
        else
            @page = 1
        end

        if params[:rows]
            if params[:rows].to_i > 50
                @rows = 50
            else
                @rows = params[:rows].to_i
            end
        else
            @rows = 10
        end

        if params[:sort]
            @sort = params[:sort]
        else
            @sort = 'id'
        end

        if params[:order]
            @order = params[:order]
        else
            @order = 'desc'
        end

        if params[:filter_rules] == nil
            @filter_rules = '[]'
        elsif params[:filter_rules] == ''
            @filter_rules = '[]'
        elsif params[:filter_rules] == '[]'
            @filter_rules = '[]'
        else
            @filter_rules = params[:filter_rules]
        end

        @startx = (@page - 1) * @rows

        @parsed_json = JSON.parse @filter_rules

        @keluaran = ''
        @parsed_json.each do |njes|
            if njes['op'] == 'equal'
                @keluaran = @keluaran+' '+njes['field']+' = \\''+njes['value']+'\\' and '
            elsif njes['op'] == 'not equal'
                @keluaran = @keluaran+' '+njes['field']+' <> \\''+njes['value']+'\' and '
            elsif njes['op'] == 'contains'
                @keluaran = @keluaran+' '+njes['field']+' like \\'%'+njes['value']+'%\\' and '
            elsif njes['op'] == 'l_contains'
                @keluaran = @keluaran+' '+njes['field']+' like \\''+njes['value']+'%\\' and '
            elsif njes['op'] == 'less'
                @keluaran = @keluaran+' '+njes['field']+' < \\''+njes['value']+'\\' and '
            elsif njes['op'] == 'greater'
                @keluaran = @keluaran+' '+njes['field']+' > \\''+njes['value']+'\\' and '
            end
        end
        @keluaran_length = @keluaran.length

        if @keluaran_length != 0
            @keluaran_where =  @keluaran[0,@keluaran_length - 4]

            @total_item = " + the_model + ".where(@keluaran_where).size
            @total_page = (@total_item.to_f/@rows.to_i).ceil
            @datas = " + the_model + ".where(@keluaran_where).order(@sort+' '+@order).limit(@rows).offset(@startx)
        else

            @total_item = " + the_model + ".all.size
            @total_page = (@total_item.to_f/@rows.to_i).ceil
            @datas = " + the_model + ".all.order(@sort+' '+@order).limit(@rows).offset(@startx)
        end

        @urlfor = url_for({controller: '/" + the_namespace.downcase + "/" + the_controller.downcase + "', action: 'index'})
    end
"
end


def create_controller_new(the_namespace, the_controller, the_model, the_fields)
"
    def new
        @" + the_model.downcase + " = " + the_model + ".new
    end
"
end


def create_controller_create(the_namespace, the_controller, the_model, the_fields)

    @tfs = ''
    the_fields.each do |tf|
        @tfs = @tfs + ', ' + tf.to_s + ': params[:' + the_model.downcase + '][:' + tf.to_s + ']'
    end

"
    def create
        @" + the_model.downcase + " = " + the_model + ".create({
            " + @tfs[1..@tfs.length] + "
        })

        redirect_to action: 'index'
    end
"
end


def create_controller_show(the_namespace, the_controller, the_model, the_fields)
"
    def show
        @" + the_model.downcase + " = " + the_model + ".find(params[:id].to_i)
    end
"
end

def create_controller_edit(the_namespace, the_controller, the_model, the_fields)
"
    def edit
        @" + the_model.downcase + " = " + the_model + ".find(params[:id].to_i)
    end
"
end

def create_controller_update(the_namespace, the_controller, the_model, the_fields)

    @tfs = ''
    the_fields.each do |tf|
        @tfs = @tfs + '@' + the_model.downcase + '.' + tf.to_s + ' = params[:' + the_model.downcase + '][:' + tf.to_s + ']
        '
    end

"
    def update
        @" + the_model.downcase + " = " + the_model + ".find(params[:id].to_i)
        " + @tfs + "@" + the_model.downcase + ".save

        redirect_to action: 'index'
    end
"
end

def create_controller_destroy(the_namespace, the_controller, the_model, the_fields)
"
    def destroy
        " + the_model + ".find(params[:id].to_i).destroy

        redirect_to action: 'index'
    end
"
end
