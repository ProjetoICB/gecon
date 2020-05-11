class RelatoriosController < ApplicationController

  def por_conta

  end

  def relat_por_conta

    result = ""

    if params[:conta_id] != ""
      result = "conta_id = " + params[:conta_id].to_s
      puts result
    end

    if params[:inicio] != "" and params[:fim] != ""
      if result != ""
        result +=  " and "
      end
       result += "data between '" + params[:inicio] + "' and '" + params[:fim] + "'"
    end

     if result != ""
      @lancamentos = Lancamento.where(result).order('id desc')
      respond_to do |format|
        format.html
        format.xlsx {
          response.headers[
              'Content-Disposition'] = "attachment; filename=por_conta.xlsx"
        }
        format.pdf do
          render :pdf => 'por_conta',
                 :layout => 'layouts/padrao.html.erb',
                 :show_as_html => params[:debug].present?,
                 :template => 'relatorios/relat_por_conta.pdf.erb',
                 :page_size => 'A4',
                 :disposition => 'attachment',
                 :orientation => 'Landscape',
                 footer: {
                     left: "Impresso em: " + DateTime.current.strftime("%d/%m/%Y %H:%M"),
                     center: "Seção de Contabilidade",
                     right: '[page] de [topage]'
                 },
                 :margin => {
                     top: 20,
                     bottom: 20,
                     left: 20,
                     right: 20
                 }
        end
      end
    end
  end

  def por_lanc

  end

  def relat_por_lanc

    result = ""
    @total = 0

    if params[:centro_de_custo_id] != ""
      result = "centro_de_custo_id =  " + params[:centro_de_custo_id].to_s
    end


    if params[:inicio] != "" and params[:fim] != ""
      if result != ""
        result += " and "
      end
      result += "data between '" + params[:inicio] + "' and '" + params[:fim] + "'"
    end

    if params[:conta_id] != ""
      if result != ""
        result += " and "
      end
      result += "conta_id = " + params[:conta_id]
    end

    if result != ""
      @lancamentos  = Lancamento.joins(:conta).joins("inner join centros_de_custo cc on cc.id = contas.centro_de_custo_id").where(result).order("id desc")
      cred = Lancamento.joins(:conta).joins("inner join centros_de_custo cc on cc.id = contas.centro_de_custo_id").where(result).sum(:credito)
      deb = Lancamento.joins(:conta).joins("inner join centros_de_custo cc on cc.id = contas.centro_de_custo_id").where(result).sum(:debito)
      @total  = cred - deb


      respond_to do |format|
        format.html
        format.xlsx {
          response.headers[
              'Content-Disposition'] = "attachment; filename=por_lancamento.xlsx"
        }
        format.pdf do
          render :pdf => 'por_lancamento',
                 :layout => 'layouts/padrao.html.erb',
                 :show_as_html => params[:debug].present?,
                 :template => 'relatorios/relat_por_lanc.pdf.erb',
                 :page_size => 'A4',
                 :disposition => 'attachment',
                 :orientation => 'Landscape',
                 footer: {
                     left: "Impresso em: " + DateTime.current.strftime("%d/%m/%Y %H:%M"),
                     center: "Seção de Contabilidade",
                     right: '[page] de [topage]'
                 },
                 :margin => {
                     top: 20,
                     bottom: 20,
                     left: 20,
                     right: 20
                 }
        end
    end
    end
  end


  def gastos_por_idd

  end

  def relat_gastos_por_idd
    @inicio = params[:inicio].to_date
    @fim = params[:fim].to_date
    @totalgeral = 0
    @hoje = Date.today
    @tot_por_cat = Lancamento.joins(:item_de_despesa).joins("inner join categorias on categorias.id = itens_de_despesa.categoria_id").where("data between ? and ?", @inicio, @fim).group("categorias.nome").order('categorias.nome').pluck('categorias.id', 'categorias.nome','sum(debito)')
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers[
            'Content-Disposition'] = "attachment; filename=relat_gastos_por_idd.xlsx"
      }
      format.pdf do
        render :pdf => 'gastos_itens_de_despesa',
               :layout => 'layouts/padrao.html.erb',
               :show_as_html => params[:debug].present?,
               :template => 'relatorios/relat_gastos_por_idd.pdf.erb',
               :page_size => 'A4',
               :disposition => 'attachment',
               footer: {
                   left: "Impresso em: " + DateTime.current.strftime("%d/%m/%Y %H:%M"),
                   center: "Seção de Contabilidade",
                   right: '[page] de [topage]'
               },
               :margin => {
                   top: 20,
                   bottom: 20,
                   left: 20,
                   right: 20
               }
      end
    end
  end
end
