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
              'Content-Disposition'] = "attachment; filename=relat_conta.xlsx"
        }
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
      puts result
    end


    if params[:inicio] != "" and params[:fim] != ""
      if result != ""
        result += " and "
      end
      result += "data between '" + params[:inicio] + "' and '" + params[:fim] + "'"
      puts result

    end

    if params[:conta_id] != ""
      if result != ""
        result += " and "
      end
      result += "conta_id = " + params[:conta_id]
      puts result
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
              'Content-Disposition'] = "attachment; filename=relat_porlanc.xlsx"
        }
      end
    end
  end




end
