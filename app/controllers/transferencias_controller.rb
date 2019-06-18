class TransferenciasController < ApplicationController
  before_action :set_transferencia, only: [:show, :edit, :update, :destroy]

  # GET /transferencias
  # GET /transferencias.json


  def transf_multipla

  end

  def gera_transf_multipla

    debito_id = params[:debito_id]
    cred1 = params[:cred1]
    cred2 = params[:cred2]
    cred3 = params[:cred3]
    cred4 = params[:cred4]

    # Eliminar essas condições se todos os campos de credito sempre forem preenchidos
    if cred1.empty?
      cred1 = 0
    end

    if cred2.empty?
      cred2 = -1
    end

    if cred3.empty?
      cred3 = -2
    end

    if cred4.empty?
      cred4 = -3
    end

    valor = params[:valor].to_i
    data = params[:data]
    datadocumento = params[:datadocumento]

    if (debito_id != cred1) and (debito_id != cred2) and (debito_id != cred3) and (debito_id != cred4)
     if (cred1 == cred2) or (cred1 == cred3) or (cred1 == cred4) or (cred2 == cred3) or (cred2 == cred4) or (cred3 == cred4)
        redirect_to transferencias_path, notice: "Impossivel fazer crédito em duas contas iguais"
     else
        totalporc = params[:porc1].to_i + params[:porc2].to_i + params[:porc3].to_i + params[:porc4].to_i
        if totalporc <= 100
          @lancamento = Lancamento.new
          @lancamento.tipo = "Débito"
          @lancamento.data = data
          @lancamento.datadocumento = datadocumento
          @lancamento.conta_id = debito_id
          @lancamento.debito = valor
          #@lancamento.transferencia_id = tm.id
          @lancamento.save


          if !params[:cred1].empty?
            tm = Transferencia.new
            tm.data = data
            tm.datadocumento = datadocumento
            tm.debito_id = params[:debito_id]
            tm.valor_deb_orig = params[:valor]
            tm.credito_id = params[:cred1]
            tm.porcentagem = params[:porc1]
            tm.transf_multipla = true
            tm.valor = (valor / 100) * params[:porc1].to_i
            tm.save
            @lancamento = Lancamento.new
            @lancamento.tipo = "Crédito"
            @lancamento.data = data
            @lancamento.datadocumento = datadocumento
            @lancamento.conta_id = tm.credito_id
            @lancamento.credito = tm.valor
            @lancamento.transferencia_id = tm.id
            @lancamento.save
          end
          if !params[:cred2].empty?
            tm = Transferencia.new
            tm.data = data
            tm.datadocumento = datadocumento
            tm.debito_id = params[:debito_id]
            tm.credito_id = params[:cred2]
            tm.valor_deb_orig = params[:valor]
            tm.porcentagem = params[:porc2]
            tm.transf_multipla = true
            tm.valor = (valor / 100) * params[:porc2].to_i
            tm.save
            @lancamento = Lancamento.new
            @lancamento.tipo = "Crédito"
            @lancamento.data = data
            @lancamento.datadocumento = datadocumento
            @lancamento.conta_id = tm.credito_id
            @lancamento.credito = tm.valor
            @lancamento.transferencia_id = tm.id
            @lancamento.save
          end
          if !params[:cred3].empty?
            tm = Transferencia.new
            tm.data = data
            tm.datadocumento = datadocumento
            tm.debito_id = params[:debito_id]
            tm.valor_deb_orig = params[:valor]
            tm.credito_id = params[:cred3]
            tm.porcentagem = params[:porc3]
            tm.transf_multipla = true
            tm.valor = (valor / 100) * params[:porc3].to_i
            tm.save
            @lancamento = Lancamento.new
            @lancamento.tipo = "Crédito"
            @lancamento.data = data
            @lancamento.datadocumento = datadocumento
            @lancamento.conta_id = tm.credito_id
            @lancamento.credito = tm.valor
            @lancamento.transferencia_id = tm.id
            @lancamento.save
          end
          if !params[:cred4].empty?
            tm = Transferencia.new
            tm.data = data
            tm.datadocumento = datadocumento
            tm.debito_id = params[:debito_id]
            tm.valor_deb_orig = params[:valor]
            tm.credito_id = params[:cred4]
            tm.porcentagem = params[:porc4]
            tm.transf_multipla = true
            tm.valor = (valor / 100) * params[:porc4].to_i
            tm.save
            @lancamento = Lancamento.new
            @lancamento.tipo = "Crédito"
            @lancamento.data = data
            @lancamento.datadocumento = datadocumento
            @lancamento.conta_id = tm.credito_id
            @lancamento.credito = tm.valor
            @lancamento.transferencia_id = tm.id
            @lancamento.save
          end
          redirect_to transferencias_path, notice: "Transferências realizadas com sucesso"
        else
          redirect_to transferencias_path, notice: "Transferencias não realizadas! Porcentagens maiores que 100%! "
        end
      end
    else
      redirect_to transferencias_path, notice: "Impossivel fazer crédito na mesma conta de débito"
    end
  end

  def edita_transf_multipla
    set_transferencia
    @porc =  @transferencia.porcentagem
  end

  def atualiza_transf_multipla
    cred = params[:cred]
    porc = params[:porc]
    id = params[:id]
    puts cred.to_s + " / " + porc.to_s + " / " + id.to_s

    if !params[:porc].empty?
      tm = Transferencia.find(params[:id])
      totalporc = Transferencia.where(created_at: tm.created_at, transf_multipla: true).sum(:porcentagem)
      puts totalporc
      if totalporc >= 100
        redirect_to transferencias_path, notice: "Transferencias não realizadas! Porcentagens maiores que 100%"
      else
        tm.credito_id = cred
        tm.porcentagem = porc
        tm.valor = (tm.valor_deb_orig / 100) * porc.to_i
        tm.save
        @lancamento = Lancamento.find_by(transferencia_id: id)
        @lancamento.conta_id  = tm.credito_id
        @lancamento.credito = tm.valor
        @lancamento.transferencia_id = tm.id
        @lancamento.save
        redirect_to transferencias_path, notice: "Transferência alterada com sucesso"
      end
    end
  end

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



  def index
    @transferencias = Transferencia.all.order("id desc")
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
        if @transferencia.credito_id == @transferencia.debito_id
          @transferencia.destroy
          format.html { redirect_to transferencias_path, notice: "Você não pode fazer transferencias para duas contas iguais" }
        else
          cria_credito
          cria_debito
          format.html { redirect_to @transferencia, notice: 'Transferência criada com sucesso .' }
          format.json { render :show, status: :created, location: @transferencia }
        end
      else
        format.html { render :new }
        format.json { render json: @transferencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transferencias/1
  # PATCH/PUT /transferencias/1.json



  def update
    respond_to do |format|
      if @transferencia.update(transferencia_params)
        if @transferencia.credito_id == @transferencia.debito_id
          format.html { redirect_to edit_transferencia_path(transferencia_params), notice: "Você não pode fazer transferencias para duas contas iguais" }
        else
          editacredito
          editadebito
          format.html { redirect_to @transferencia, notice: 'Transferência atualizada com sucesso.' }
          format.json { render :show, status: :ok, location: @transferencia }
        end
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
      params.require(:transferencia).permit(:data, :datadocumento, :debito_id, :credito_id, :valor, :observacao, :fornecedor_id, :num_notafiscal, :empenho, :porcentagem, :transf_multipla, :valor_deb_orig)
    end
end
