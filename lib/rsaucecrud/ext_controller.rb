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
    advanced_page_and_filter(#{the_model}.column_names)

    if @keluaran_length != 0
      @total_item = #{the_model}.where(@nu_where).size
      @total_page = (@total_item.to_f / @rows.to_i).ceil
     @datas = #{the_model}.where(@nu_where).order(@sort + ' ' + @order).limit(@rows).offset(@startx)
    else
      @total_item = #{the_model}.all.size
      @total_page = (@total_item.to_f / @rows.to_i).ceil
      @datas = #{the_model}.all.order(@sort + ' ' + @order).limit(@rows).offset(@startx)
    end

    @urlfor = url_for(action: 'index')
  end
"
end


def create_controller_new(the_namespace, the_controller, the_model, the_fields)
"
  def new
    @#{the_model.downcase} = #{the_model}.new
  end
"
end


def create_controller_create(the_namespace, the_controller, the_model, the_fields)

    @tfs = ''
    the_fields.each do |tf|
        if tf.to_s != 'id' && tf.to_s != 'created_at' && tf.to_s != 'updated_at'
            @tfs = @tfs + ',
            ' + tf.to_s + ': params[:' + the_model.downcase + '][:' + tf.to_s + ']'
        end
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
        if tf.to_s != 'id' && tf.to_s != 'created_at' && tf.to_s != 'updated_at'
            @tfs = @tfs + '@' + the_model.downcase + '.' + tf.to_s + ' = params[:' + the_model.downcase + '][:' + tf.to_s + ']
            '
        end
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
