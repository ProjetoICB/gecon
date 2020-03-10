class RelUsuariosController < ApplicationController

  #6#
  def plano_de_contas
    @itens_de_despesa = ItemDeDespesa.where(ativo:  true)
    respond_to do |format|
      format.pdf do
        render :pdf => 'plano_de_contas',
               :layout => 'layouts/padrao.html.erb',
               :show_as_html => params[:debug].present?,
               :template => 'rel_usuarios/plano_de_contas.pdf.erb',
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

  #1#
  def resumo
    @total = 0
    @hoje = Date.today
    @contas = Conta.where(usuario_id: session[:usuario_id])
    respond_to do |format|
      format.pdf do
        render :pdf => 'resumo',
               :layout => 'layouts/padrao.html.erb',
               :show_as_html => params[:debug].present?,
               :template => 'rel_usuarios/resumo.pdf.erb',
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


  #2#
  def detalhamento
    @contas = Conta.where(usuario_id:  session[:usuario_id])
  end

  def result_detalhamento
    @total = 0
    @hoje = Date.today
    @result = Conta.where(id: params[:contas])
      respond_to do |format|
        format.pdf do
               render :pdf => 'detalhamento',
                      :layout => 'layouts/padrao.html.erb',
                      :show_as_html => params[:debug].present?,
                      :template => 'rel_usuarios/res_detalhamento.pdf.erb',
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

  #5#
  def itens_de_despesa
  end

  def result_idd
    @inicio = params[:inicio].to_date
    @fim = params[:fim].to_date
    @totalgeral = 0
    @hoje = Date.today
    @result = ItemDeDespesa.joins(:lancamentos).distinct.where("data between ?  and ?", @inicio, @fim).order('id')
    @totalgeral = Lancamento.joins(:item_de_despesa).where("data between ? and ?", @inicio, @fim).sum(:debito)
    respond_to do |format|
      format.pdf do
        render :pdf => 'itens_de_despesa',
               :layout => 'layouts/padrao.html.erb',
               :show_as_html => params[:debug].present?,
               :template => 'rel_usuarios/res_itens_depesa.pdf.erb',
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

  #4#
  def balancete
  end

  def res_balancete
    @fim = params[:fim].to_date
    @hoje = Date.today
    @result = Lancamento.joins(:conta)
                  .joins("inner join centros_de_custo on centros_de_custo.id = contas.centro_de_custo_id ")
                  .where("lancamentos.data <= ?", params[:fim])
                  .group("centros_de_custo.nome")
                  .pluck('centros_de_custo.nome','sum(credito)', 'sum(debito)')
    cred = Lancamento.joins(:conta)
        .joins("inner join centros_de_custo on centros_de_custo.id = contas.centro_de_custo_id ")
        .where("lancamentos.data <= ?", params[:fim]).sum(:credito)
    deb = Lancamento.joins(:conta)
              .joins("inner join centros_de_custo on centros_de_custo.id = contas.centro_de_custo_id ")
              .where("lancamentos.data <= ?", params[:fim]).sum(:debito)
    @total = cred - deb

    respond_to do |format|
      format.pdf do
        render :pdf => 'balancete',
               :layout => 'layouts/padrao.html.erb',
               :show_as_html => params[:debug].present?,
               :template => 'rel_usuarios/balancete.pdf.erb',
               :page_size => 'A4',
               :disposition => 'attachment',
               footer: {
                   left: "Impresso em " + DateTime.current.strftime("%d/%m/%Y"),
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

  #3#
  def resumo_icb

    @departamentos = Departamento.where("id between 2 and 8").order('sigla')
    @tipos_de_conta = TipoDeConta.all

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => 'resumo_icb',
               :layout => 'layouts/padrao.html.erb',
               :show_as_html => params[:debug].present?,
               :template => 'rel_usuarios/resumo_icb.pdf.erb',
               :page_size => 'A4',
               :orientation => 'Landscape',
               :disposition => 'attachment',
               footer: {
                   left: "Impresso em " + DateTime.current.strftime("%d/%m/%Y"),
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