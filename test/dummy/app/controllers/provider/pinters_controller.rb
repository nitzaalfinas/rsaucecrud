class Provider::PintersController < ApplicationController

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
                @keluaran = @keluaran+' '+njes['field']+' = \''+njes['value']+'\' and '
            elsif njes['op'] == 'not equal'
                @keluaran = @keluaran+' '+njes['field']+' <> \''+njes['value']+'\' and '
            elsif njes['op'] == 'contains'
                @keluaran = @keluaran+' '+njes['field']+' like \'%'+njes['value']+'%\' and '
            elsif njes['op'] == 'l_contains'
                @keluaran = @keluaran+' '+njes['field']+' like \''+njes['value']+'%\' and '
            elsif njes['op'] == 'less'
                @keluaran = @keluaran+' '+njes['field']+' < \''+njes['value']+'\' and '
            elsif njes['op'] == 'greater'
                @keluaran = @keluaran+' '+njes['field']+' > \''+njes['value']+'\' and '
            end
        end
        @keluaran_length = @keluaran.length

        if @keluaran_length != 0
            @keluaran_where =  @keluaran[0,@keluaran_length - 4]

            @total_item = Pinter.where(@keluaran_where).size
            @total_page = (@total_item.to_f/@rows.to_i).ceil
            @datas = Pinter.where(@keluaran_where).order(@sort+' '+@order).limit(@rows).offset(@startx)
        else

            @total_item = Pinter.all.size
            @total_page = (@total_item.to_f/@rows.to_i).ceil
            @datas = Pinter.all.order(@sort+' '+@order).limit(@rows).offset(@startx)
        end

        @urlfor = url_for({controller: '/provider/pinters', action: 'index'})
    end

    def new
        @pinter = Pinter.new
    end

    def create
        @pinter = Pinter.create({
             satu: params[:pinter][:satu], dua: params[:pinter][:dua], tiga: params[:pinter][:tiga]
        })

        redirect_to action: 'index'
    end

    def show
        @pinter = Pinter.find(params[:id].to_i)
    end

    def edit
        @pinter = Pinter.find(params[:id].to_i)
    end

    def update
        @pinter = Pinter.find(params[:id].to_i)
        @pinter.satu = params[:pinter][:satu]
        @pinter.dua = params[:pinter][:dua]
        @pinter.tiga = params[:pinter][:tiga]
        @pinter.save

        redirect_to action: 'index'
    end

    def destroy
        Pinter.find(params[:id].to_i).destroy

        redirect_to action: 'index'
    end

end