class TransferenciasController < ApplicationController
  before_action :set_transferencia, only: [:show, :edit, :update, :destroy]

  # GET /transferencias
  # GET /transferencias.json
  def index
    @transferencias = Transferencia.all
  end

  # GET /transferencias/1
  # GET /transferencias/1.json
  def show
    set_transferencia
    @deb = Conta.find(@transferencia.debito_id)
    @cred = Conta.find(@transferencia.credito_id)
  end

  # GET /transferencias/new
  def new
    @transferencia = Transferencia.new
  end

  # GET /transferencias/1/edit
  def edit
  end

  # POST /transferencias
  # POST /transferencias.json
  def create
    @transferencia = Transferencia.new(transferencia_params)

    respond_to do |format|
      if @transferencia.save
        cria_credito
        cria_debito
        format.html { redirect_to @transferencia, notice: 'Transferência criada com sucesso .' }
        format.json { render :show, status: :created, location: @transferencia }
      else
        format.html { render :new }
        format.json { render json: @transferencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transferencias/1
  # PATCH/PUT /transferencias/1.json

  def cria_debito
    @transferencia = Transferencia.last
    @lancamento = Lancamento.new
    @lancamento.tipo = "Débito"
    @lancamento.data = @transferencia.data
    @lancamento.datadocumento = @transferencia.datadocumento
    @lancamento.observacao = @transferencia.observacao
    @lancamento.debito = @transferencia.valor
    @lancamento.conta_id = @transferencia.debito_id
    @lancamento.transferencia_id = @transferencia.id
    @lancamento.save!
  end

  def cria_credito
    @transferencia = Transferencia.last
    @lancamento = Lancamento.new
    @lancamento.tipo = "Crédito"
    @lancamento.data = @transferencia.data
    @lancamento.datadocumento = @transferencia.datadocumento
    @lancamento.observacao = @transferencia.observacao
    @lancamento.credito = @transferencia.valor
    @lancamento.conta_id = @transferencia.credito_id
    @lancamento.transferencia_id = @transferencia.id
    @lancamento.save!
  end

  def editadebito
    set_transferencia
    @lancamento = Lancamento.find_by("transferencia_id = ?  and tipo = ?", @transferencia.id, "Débito")
    @lancamento.data = @transferencia.data
    @lancamento.datadocumento = @transferencia.datadocumento
    @lancamento.observacao = @transferencia.observacao
    @lancamento.debito = @transferencia.valor
    @lancamento.conta_id = @transferencia.debito_id
    @lancamento.save!
  end

  def editacredito
    set_transferencia
    @lancamento = Lancamento.find_by("transferencia_id = ?  and tipo = ?", @transferencia.id, "Crédito")
    @lancamento.data = @transferencia.data
    @lancamento.datadocumento = @transferencia.datadocumento
    @lancamento.observacao = @transferencia.observacao
    @lancamento.credito = @transferencia.valor
    @lancamento.conta_id = @transferencia.credito_id
    @lancamento.save!
  end

  def update
    respond_to do |format|
      if @transferencia.update(transferencia_params)
        editacredito
        editadebito
        format.html { redirect_to @transferencia, notice: 'Transferência atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @transferencia }
      else
        format.html { render :edit }
        format.json { render json: @transferencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transferencias/1
  # DELETE /transferencias/1.json
  def destroy
    @transferencia.destroy
    respond_to do |format|
      format.html { redirect_to transferencias_url, notice: 'Transferência apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transferencia
      @transferencia = Transferencia.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transferencia_params
      params.require(:transferencia).permit(:data, :datadocumento, :debito_id, :credito_id, :valor, :observacao, :fornecedor_id, :num_notafiscal, :empenho)
    end
end
