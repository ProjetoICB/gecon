class LancamentosController < ApplicationController
  before_action :set_lancamento, only: [:show, :edit, :update, :destroy]

  def busca
  end

  def result

    busca = ""

    if params[:processo] != ""
      busca = "processo = " + params[:processo].to_s
    end


    if params[:fornecedor_id] != ""
      if busca != ""
        busca += " and "
      end
      busca += "fornecedor_id = " + params[:fornecedor_id].to_s
    end

    if params[:conta_id] != ""
      if busca != ""
        busca += " and "
      end
      busca += "conta_id = " + params[:conta_id].to_s
    end

    if params[:item_de_despesa_id] != ""
      if busca != ""
        busca += " and "
      end
      busca += "item_de_despesa_id = " + params[:item_de_despesa_id].to_s
    end

    if params[:tipo_de_compra_id] != ""
      if busca != ""
        busca += " and "
      end
      busca += "tipo_de_compra_id = " + params[:tipo_de_compra_id].to_s
    end

    if params[:inicio] != "" and params[:fim] != ""
      if busca != ""
        busca += " and "
      end
      busca +=  "data between '" + params[:inicio] + "' and '" + params[:fim] + "'"
    end

    if params[:debito_canc] == "Sim"
      if busca != ""
        busca += " and "
      end
      busca += "debito_cancelado is true"
    end



    if busca != ""
      #if params[:debito_canc] == "Sim"
      #  @lancamentos = Lancamento.where(debito_cancelado: true).where(busca).order("id desc")
      #else
        @lancamentos = Lancamento.where(busca).order("id desc")
      #end
    else
      @lancamentos =  Lancamento.all.order("id desc")
    end

 end



  # GET /lancamentos
  # GET /lancamentos.json
  def index
    @lancamentos = Lancamento.all.order("id desc")
  end

  # GET /lancamentos/1
  # GET /lancamentos/1.json
  def show
  end

  # GET /lancamentos/new
  def new
    @lancamento = Lancamento.new
  end

  # GET /lancamentos/1/edit
  def edit
    set_lancamento
  end

  # POST /lancamentos
  # POST /lancamentos.json
  def create
    @lancamento = Lancamento.new(lancamento_params)

    respond_to do |format|
      if @lancamento.save
        format.html { redirect_to @lancamento, notice: 'Lançamento criado com sucesso.' }
        format.json { render :show, status: :created, location: @lancamento }
      else
        format.html { render :new }
        format.json { render json: @lancamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lancamentos/1
  # PATCH/PUT /lancamentos/1.json
  def update
    respond_to do |format|
      if @lancamento.update(lancamento_params)
        format.html { redirect_to @lancamento, notice: 'Lançamento atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @lancamento }
      else
        format.html { render :edit }
        format.json { render json: @lancamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lancamentos/1
  # DELETE /lancamentos/1.json
  def destroy
    @lancamento.destroy
    respond_to do |format|
      format.html { redirect_to lancamentos_url, notice: 'Lançamento apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lancamento
      @lancamento = Lancamento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lancamento_params
      params.require(:lancamento).permit(:processo, :data, :datadocumento, :observacao, :debito, :credito, :tipo, :conta_id, :fornecedor_id, :item_de_despesa_id, :item_de_receita_id, :tipo_de_compra_id, :debito_cancelado, :retorno_debitocanc, :num_notafiscal, :empenho)
    end
end
