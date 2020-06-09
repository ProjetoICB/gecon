class RelUsuariosController < ApplicationController

  #6#
  def plano_de_contas
    @itens_de_despesa = ItemDeDespesa.where(ativo: true)
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
    @contas = Conta.where(usuario_id: session[:usuario_id])
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
      format.html
      format.xlsx {
        response.headers[
            'Content-Disposition'] = "attachment; filename=itens_de_despesa.xlsx"
      }
      format.pdf do
        render :pdf => 'itens_de_despesa',
               :layout => 'layouts/padrao.html.erb',
               :show_as_html => params[:debug].present?,
               :template => 'rel_usuarios/result_idd.pdf.erb',
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

    if params[:grupo_id].empty?
      @result = Lancamento.joins(:conta)
                    .joins("inner join centros_de_custo on centros_de_custo.id = contas.centro_de_custo_id ")
                    .joins("inner join tipo_de_contas on tipo_de_contas.id = contas.tipo_de_conta_id")
                    .joins("inner join grupos on tipo_de_contas.grupo_id = grupos.id")
                    .where("lancamentos.data <= ? and centros_de_custo.ativo = ? and grupos.ativo = ?  ", params[:fim], true, true)
                    .group("centros_de_custo.nome", "grupos.nome")
                    .order("grupos.nome, centros_de_custo.nome")
                    .pluck("centros_de_custo.nome", "sum(credito)", "sum(debito)", "grupos.nome")

      cred = Lancamento.joins(:conta)
                 .joins("inner join centros_de_custo on centros_de_custo.id = contas.centro_de_custo_id ")
                 .joins("inner join tipo_de_contas on tipo_de_contas.id = contas.tipo_de_conta_id")
                 .joins("inner join grupos on tipo_de_contas.grupo_id = grupos.id")
                 .where("lancamentos.data <= ? and centros_de_custo.ativo = ? and grupos.ativo = ?", params[:fim], true, true).sum(:credito)

      deb = Lancamento.joins(:conta)
                .joins("inner join centros_de_custo on centros_de_custo.id = contas.centro_de_custo_id ")
                .joins("inner join tipo_de_contas on tipo_de_contas.id = contas.tipo_de_conta_id")
                .joins("inner join grupos on tipo_de_contas.grupo_id = grupos.id")
                .where("lancamentos.data <= ? and centros_de_custo.ativo = ? and grupos.ativo = ?", params[:fim], true, true).sum(:debito)

      @total = cred - deb
    else
      @grupo = Grupo.find(params[:grupo_id])
      @result = Lancamento.joins(:conta)
                    .joins("inner join centros_de_custo on centros_de_custo.id = contas.centro_de_custo_id ")
                    .joins("inner join tipo_de_contas on tipo_de_contas.id = contas.tipo_de_conta_id")
                    .joins("inner join grupos on tipo_de_contas.grupo_id = grupos.id")
                    .where("lancamentos.data <= ? and centros_de_custo.ativo = ? and tipo_de_contas.grupo_id = ?", params[:fim], true, params[:grupo_id])
                    .group("centros_de_custo.nome")
                    .pluck('centros_de_custo.nome', 'sum(credito)', 'sum(debito)')

      cred = Lancamento.joins(:conta)
                 .joins("inner join centros_de_custo on centros_de_custo.id = contas.centro_de_custo_id ")
                 .joins("inner join tipo_de_contas on tipo_de_contas.id = contas.tipo_de_conta_id")
                 .joins("inner join grupos on tipo_de_contas.grupo_id = grupos.id")
                 .where("lancamentos.data <= ? and centros_de_custo.ativo = ? and tipo_de_contas.grupo_id = ?", params[:fim], true, params[:grupo_id]).sum(:credito)

      deb = Lancamento.joins(:conta)
                .joins("inner join centros_de_custo on centros_de_custo.id = contas.centro_de_custo_id ")
                .joins("inner join tipo_de_contas on tipo_de_contas.id = contas.tipo_de_conta_id")
                .joins("inner join grupos on tipo_de_contas.grupo_id = grupos.id")
                .where("lancamentos.data <= ? and centros_de_custo.ativo = ? and tipo_de_contas.grupo_id = ?", params[:fim], true, params[:grupo_id]).sum(:debito)

      @total = cred - deb
    end


    respond_to do |format|
      format.html
      format.xlsx {
        response.headers[
            'Content-Disposition'] = "attachment; filename=res_balancete.xlsx"
      }
      format.pdf do
        render :pdf => 'res_balancete',
               :layout => 'layouts/padrao.html.erb',
               :show_as_html => params[:debug].present?,
               :template => 'rel_usuarios/res_balancete.pdf.erb',
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
    @linhas = Array.new
    total_tc = 0
    total_dep = 0
    bma = 0
    bmb = 0     # fisio
    bmc = 0
    bmf = 0
    bmi = 0
    bmm = 0
    bmp = 0
    anat = 0
    biof = 0
    bioc = 0
    farm = 0
    imu = 0
    mic = 0
    par = 0

    @tipos_de_conta.each do |tc|
      total_tc = 0
      total_dep = 0
      bma = 0
      bmb = 0     # fisio
      bmc = 0
      bmf = 0
      bmi = 0
      bmm = 0
      bmp = 0


      @departamentos.each do |dep|
        @result = Lancamento.joins(:conta)
                      .joins("inner join usuarios u on `contas`.usuario_id = u.id")
                      .joins("inner join departamentos d on u.departamento_id = d.id")
                      .where("conta_id in (select id from contas where tipo_de_conta_id = ?) and d.id = ?", tc,dep)
                      .group("tipo_de_conta_id")
                      .pluck("sum(credito) - sum(debito)")

        @result.each do |r|
          case dep.id
            when 2
              bma = r if !r.nil? and (r > -0.0000000000000000000000001 or r < -0.99999999999999999999999999)
            when 5
              bmb = r if !r.nil? and (r > -0.0000000000000000000000001 or r < -0.99999999999999999999999999)
            when 3
              bmc = r if !r.nil? and (r > -0.0000000000000000000000001 or r < -0.99999999999999999999999999)
            when 4
              bmf = r if !r.nil? and (r > -0.0000000000000000000000001 or r < -0.99999999999999999999999999)
            when 6
              bmi = r if !r.nil? and (r > -0.0000000000000000000000001 or r < -0.99999999999999999999999999)
            when 7
              bmm = r if !r.nil? and (r > -0.0000000000000000000000001 or r < -0.99999999999999999999999999)
            when 8
              bmp = r if !r.nil? and (r > -0.0000000000000000000000001 or r < -0.99999999999999999999999999)
          end
        end
      end

      total_tc = bma + bmb + bmc + bmf + bmi + bmm + bmp

      if total_tc != 0.00 and (total_tc > -0.0000000000000000000000001 or total_tc < -0.99999999999999999999999999)
        linha =  [tc.nome, bma, bmb, bmc, bmf, bmi, bmm, bmp, total_tc]
        @linhas << linha
      end
    end


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