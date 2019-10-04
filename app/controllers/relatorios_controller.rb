class RelatoriosController < ApplicationController

  def por_conta

  end

  def relat_por_conta


    result = ""

    if params[:conta_id] != ""
      result = "conta_id = " + params[:conta_id].to_s
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
end
