def create_controller_all(the_namespace, the_controller, the_model, the_fields)

  @the_file_name = the_controller.downcase + '_controller.rb'

  dir_name = Rails.root.to_s + '/app/controllers/' + the_namespace.downcase
  FileUtils.mkdir_p dir_name

  File.open(dir_name + '/' + @the_file_name, 'w') do |f|

    f.write 'class ' + the_namespace + '::' + the_controller + 'Controller < ApplicationController'

    f.write create_class_method

    f.write create_controller_index(the_namespace, the_controller, the_model, the_fields)

    f.write create_controller_new(the_namespace, the_controller, the_model, the_fields)

    f.write create_controller_create(the_namespace, the_controller, the_model, the_fields)

    f.write create_controller_show(the_namespace, the_controller, the_model, the_fields)

    f.write create_controller_edit(the_namespace, the_controller, the_model, the_fields)

    f.write create_controller_update(the_namespace, the_controller, the_model, the_fields)

    f.write create_controller_delete(the_namespace, the_controller, the_model, the_fields)

    f.write create_controller_private(the_namespace, the_controller, the_model, the_fields)

    f.write "\n" + 'end'
  end

end

def create_class_method
"
  layout 'sp_lte'
  before_action :login_sp_required
  before_action :menu_active
  protect_from_forgery only: []
"
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
    @data = #{the_model}.new
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
    @data = " + the_model + ".create({
      " + @tfs[1..@tfs.length] + "
    })

    redirect_to action: 'index'
  end
"
end


def create_controller_show(the_namespace, the_controller, the_model, the_fields)
"
  def show
    @data = #{the_model}.find(params[:id])
  end
"
end

def create_controller_edit(the_namespace, the_controller, the_model, the_fields)
"
  def edit
    @data = #{the_model}.find(params[:id])
  end
"
end

def create_controller_update(the_namespace, the_controller, the_model, the_fields)

  @tfs = ''
  the_fields.each do |tf|
    if tf.to_s != 'id' && tf.to_s != 'created_at' && tf.to_s != 'updated_at'
      @tfs = "#{@tfs} @data.#{tf.to_s} = dparam[:#{tf.to_s}]
      "
    end
  end

"
  def update
    @id = params[:id]

    dparam = params[:#{the_model.downcase}]

    @data = #{the_model}.find(@id)
    " + @tfs + "@data.save

    redirect_to action: 'index', page: params[:page], rows: params[:rows], sort: params[:sort], order: params[:order], filter_rules: params[:filter_rules], anchor: \"box_\#{@id}\"
  end
"
end

def create_controller_delete(the_namespace, the_controller, the_model, the_fields)
"
  def delete
    @id = params[:id]

    @data = #{the_model}.find(@id)

    if @data == nil
      flash[:notif] = 'Fail'
      redirect_to action: 'index'
    else
      @data.destroy
      flash[:notif] = 'Deleted'
      redirect_to action: 'index'
    end
  end
"
end

def create_controller_private(the_namespace, the_controller, the_model, the_fields)
"
  private
  def menu_active
    @menu_#{the_controller.downcase} = 'active'
  end
"
end
