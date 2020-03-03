class ContasController < ApplicationController
  before_action :set_conta, only: [:show, :edit, :update, :destroy, :desativa_conta]

  # GET /contas
  # GET /contas.json

  def busca_conta

  end


  def result_conta

    busca = ""

    if params[:conta_id] != ""
      busca = "contas.id = " + params[:conta_id].to_s
    end

    if params[:departamento_id] != ""
      if busca != ""
        busca += " and "
      end
      busca += "`usuarios`.departamento_id = " + params[:departamento_id].to_s
      puts "Busca por departamento junto com usuario esta saindo assim: " + busca.to_s
    end

    if params[:usuario_id] != ""
      if busca != ""
        busca += " and "
      end
      busca += "usuario_id = " + params[:usuario_id].to_s
    end

    if params[:centro_de_custo_id] != ""
      if busca != ""
        busca += " and "
      end
      busca += "centro_de_custo_id = " + params[:centro_de_custo_id].to_s
    end

    if params[:fonte_de_recurso_id] != ""
      if busca != ""
        busca += " and "
      end
      busca += "fonte_de_recurso_id = " + params[:fonte_de_recurso_id].to_s
    end

    if params[:tipo_de_conta_id] != ""
      if busca != ""
        busca += " and "
      end
      busca += "tipo_de_conta_id = " + params[:tipo_de_conta_id].to_s
    end


    if params[:tudo] == "Sim"
      if params[:departamento_id] != ""
        @contas = Conta.joins(:usuario).where(busca).order('id')
      else
        @contas = Conta.where(busca).order('id')
      end
    else
      if params[:departamento_id] != ""
        @contas = Conta.joins(:usuario).where(busca).where(ativo: true).order('id')
      else
        @contas = Conta.where(busca).where(ativo: true).order('id')
      end
    end
  end


  def index
    @contas = Conta.where(ativo: true).includes(:lancamentos).includes(:tipo_de_conta).includes(:usuario).includes(:centro_de_custo).includes(:fonte_de_recurso)
  end

  # GET /contas/1
  # GET /contas/1.json
  def show
    cred_conta = Lancamento.where("credito != ?" , nil?).where(conta_id: @conta.id).sum(:credito)
    deb_conta = Lancamento.where("debito != ?" , nil?).where(conta_id: @conta.id).sum(:debito)
    debito_cancelado = Lancamento.where(debito_cancelado: true).where(conta_id: @conta.id).take
    retorno_deb_canc = Lancamento.where("retorno_debitocanc != ?", nil?).where(conta_id: @conta.id).sum(:retorno_debitocanc)
    if !debito_cancelado.nil?
      @saldo = cred_conta - deb_conta + retorno_deb_canc
    else
      @saldo = cred_conta - deb_conta
    end
  end

  # GET /contas/new
  def new
    @conta = Conta.new
  end

  # GET /contas/1/edit
  def edit
  end

  # POST /contas
  # POST /contas.json
  def create
    @conta = Conta.new(conta_params)

    respond_to do |format|
      if @conta.save
        format.html { redirect_to @conta, notice: 'Conta criada com sucesso.' }
        format.json { render :show, status: :created, location: @conta }
      else
        format.html { render :new }
        format.json { render json: @conta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contas/1
  # PATCH/PUT /contas/1.json
  def update
    respond_to do |format|
      if @conta.update(conta_params)
        format.html { redirect_to @conta, notice: 'Conta atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @conta }
      else
        format.html { render :edit }
        format.json { render json: @conta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contas/1
  # DELETE /contas/1.json
  def destroy
    @conta.destroy
    respond_to do |format|
      format.html { redirect_to contas_url, notice: 'Conta apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  def desativa_conta
    @conta.ativo = false
    @conta.save
    respond_to do |format|
      format.html {redirect_to contas_path, notice: 'Conta desativada com sucesso' }
      format.json { head :no-content }
     end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conta
      @conta = Conta.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conta_params
      params.require(:conta).permit(:numero, :nome, :observacao, :ativo, :tipo_de_conta_id, :usuario_id, :centro_de_custo_id, :fonte_de_recurso_id)
    end
end
