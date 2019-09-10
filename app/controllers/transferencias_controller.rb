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

    valor = params[:valor].to_f
    data = params[:data]
    datadocumento = params[:datadocumento]
    observacao = params[:observacao]

    # identificador de transferencia multipla
    t=Transferencia.where(transf_multipla: true).order("id desc").take
    if t.nil?
      tmult = 1
    else
      tmult = t.transf_multipla_id
      tmult += 1
    end

    if (debito_id != cred1) and (debito_id != cred2) and (debito_id != cred3) and (debito_id != cred4)
     if (cred1 == cred2) or (cred1 == cred3) or (cred1 == cred4) or (cred2 == cred3) or (cred2 == cred4) or (cred3 == cred4)
        redirect_to transferencias_path, notice: "Impossivel fazer crédito em duas contas iguais"
     else
        totalporc = params[:porc1].to_f + params[:porc2].to_f + params[:porc3].to_f + params[:porc4].to_f
        if totalporc <= 100.00
          @lancamento = Lancamento.new
          @lancamento.tipo = "Débito"
          @lancamento.data = data
          @lancamento.datadocumento = datadocumento
          @lancamento.observacao = "Débito de transferência múltipla"
          @lancamento.conta_id = debito_id
          @lancamento.debito = valor
          @lancamento.transf_multipla_id = tmult
          @lancamento.save

          if !params[:cred1].empty?
            tm = Transferencia.new
            tm.data = data
            tm.datadocumento = datadocumento
            tm.observacao = observacao
            tm.debito_id = params[:debito_id]
            tm.credito_id = params[:cred1]
            tm.valor_deb_orig = params[:valor]
            tm.porcentagem = params[:porc1]
            tm.valor = (valor / 100) * params[:porc1].to_f
            tm.transf_multipla = true
            tm.transf_multipla_id = tmult
            tm.save

            @lancamento = Lancamento.new
            @lancamento.tipo = "Crédito"
            @lancamento.data = data
            @lancamento.datadocumento = datadocumento
            @lancamento.observacao = tm.observacao
            @lancamento.conta_id = tm.credito_id
            @lancamento.credito = tm.valor
            @lancamento.transferencia_id = tm.id
            @lancamento.transf_multipla_id = tmult
            @lancamento.save
            tm.credito_id = @lancamento.id
            tm.save
          end

          if !params[:cred2].empty?
            # fazer o mesmo if que está no cred1
            tm = Transferencia.new
            tm.data = data
            tm.datadocumento = datadocumento
            tm.observacao = observacao
            tm.debito_id = params[:debito_id]
            tm.credito_id = params[:cred2]
            tm.valor_deb_orig = params[:valor]
            tm.porcentagem = params[:porc2]
            tm.transf_multipla = true
            tm.valor = (valor / 100) * params[:porc2].to_f
            tm.transf_multipla_id = tmult
            tm.save

            @lancamento = Lancamento.new
            @lancamento.tipo = "Crédito"
            @lancamento.data = data
            @lancamento.datadocumento = datadocumento
            @lancamento.observacao = tm.observacao
            @lancamento.conta_id = tm.credito_id
            @lancamento.credito = tm.valor
            @lancamento.transferencia_id = tm.id
            @lancamento.transf_multipla_id = tmult
            @lancamento.save
            tm.credito_id = @lancamento.id
            tm.save
          end

          if !params[:cred3].empty?
            # fazer o mesmo if que está no cred1
            tm = Transferencia.new
            tm.data = data
            tm.datadocumento = datadocumento
            tm.observacao = observacao
            tm.debito_id = params[:debito_id]
            tm.valor_deb_orig = params[:valor]
            tm.credito_id = params[:cred3]
            tm.porcentagem = params[:porc3]
            tm.transf_multipla = true
            tm.valor = (valor / 100) * params[:porc3].to_f
            tm.transf_multipla_id = tmult
            tm.save

            @lancamento = Lancamento.new
            @lancamento.tipo = "Crédito"
            @lancamento.data = data
            @lancamento.datadocumento = datadocumento
            @lancamento.observacao = tm.observacao
            @lancamento.conta_id = tm.credito_id
            @lancamento.credito = tm.valor
            @lancamento.transferencia_id = tm.id
            @lancamento.transf_multipla_id = tmult
            @lancamento.save
            tm.credito_id = @lancamento.id
            tm.save
          end

          if !params[:cred4].empty?
            # fazer o mesmo if que está no cred1
            tm = Transferencia.new
            tm.data = data
            tm.datadocumento = datadocumento
            tm.observacao = observacao
            tm.debito_id = params[:debito_id]
            tm.valor_deb_orig = params[:valor]
            tm.credito_id = params[:cred4]
            tm.porcentagem = params[:porc4]
            tm.transf_multipla = true
            tm.valor = (valor / 100) * params[:porc4].to_f
            tm.transf_multipla_id = tmult
            tm.save

            @lancamento = Lancamento.new
            @lancamento.tipo = "Crédito"
            @lancamento.data = data
            @lancamento.datadocumento = datadocumento
            @lancamento.observacao = tm.observacao
            @lancamento.conta_id = tm.credito_id
            @lancamento.credito = tm.valor
            @lancamento.transferencia_id = tm.id
            @lancamento.transf_multipla_id = tmult
            @lancamento.save
            tm.credito_id = @lancamento.id
            tm.save
          end
          @lancamento = Lancamento.where("tipo = ? and transf_multipla_id = ?", "Débito", tmult).take
          @transferencia = Transferencia.where("transf_multipla_id = ?", @lancamento.transf_multipla_id)
          @transferencia.each do |t|
            t.debito_id = @lancamento.id
            t.save
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


  def cria_debito
    @transferencia = Transferencia.find(@transferencia.id)
    @lancamento = Lancamento.new
    @lancamento.tipo = "Débito"
    @lancamento.data = @transferencia.data
    @lancamento.datadocumento = @transferencia.datadocumento
    @lancamento.observacao = @transferencia.observacao
    @lancamento.debito = @transferencia.valor
    @lancamento.conta_id = @transferencia.debito_id
    @lancamento.transferencia_id = @transferencia.id
    @lancamento.save!
    # A novidade está aqui: acima, além de procurar a transferencia criada, ele cria apenas os lançamentos.
    # Nesse caso, depois de salvar o lançamento, ele guarda o valor do id do lançamento criado no campo debito_id da TRANSFERENCIA
    @transferencia.debito_id = @lancamento.id
    @transferencia.save
  end

  def cria_credito
    @transferencia =  Transferencia.find(@transferencia.id)
    @lancamento = Lancamento.new
    @lancamento.tipo = "Crédito"
    @lancamento.data = @transferencia.data
    @lancamento.datadocumento = @transferencia.datadocumento
    @lancamento.observacao = @transferencia.observacao
    @lancamento.credito = @transferencia.valor
    @lancamento.conta_id = @transferencia.credito_id
    @lancamento.transferencia_id = @transferencia.id
    @lancamento.save!
    # A mesma coisa aqui, só que agora em relação ao credito
    @transferencia.credito_id = @lancamento.id
    @transferencia.save
  end

  def editadebito(contadebito)
    t=Transferencia.find(params[:id])
    debito_id_orig = t.debito_id
    puts "Debito id orig = " + debito_id_orig.to_s
    @lancamento = Lancamento.find(debito_id_orig)
    @lancamento.data = @transferencia.data
    @lancamento.datadocumento = @transferencia.datadocumento
    @lancamento.observacao = @transferencia.observacao
    @lancamento.debito = @transferencia.valor
    @lancamento.conta_id = contadebito
    @lancamento.save
  end

  def editacredito(contacredito)
    t=Transferencia.find(params[:id])
    credito_id_orig = t.credito_id
    puts "Credito_id_orig = " + credito_id_orig.to_s
    @lancamento = Lancamento.find(credito_id_orig)
    @lancamento.data = @transferencia.data
    @lancamento.datadocumento = @transferencia.datadocumento
    @lancamento.observacao = @transferencia.observacao
    @lancamento.credito = @transferencia.valor
    @lancamento.conta_id = contacredito
    @lancamento.save

  end


  def index
    @transferencias = Transferencia.all.order("id desc")
  end

  # GET /transferencias/1
  # GET /transferencias/1.json


  def show
    set_transferencia
    ldeb = Lancamento.find(@transferencia.debito_id)
    @debito = ldeb.conta.nome
    lcred = Lancamento.find(@transferencia.credito_id)
    @credito = lcred.conta.nome
  end





  # GET /transferencias/new
  def new
    @transferencia = Transferencia.new
  end

  # GET /transferencias/1/edit
  def edit
    #@cred = Conta.joins(:lancamentos).where("transferencia_id = ? and tipo = ?  and ativo= ?", @transferencia.id, "Crédito", true).take
    #@deb = Conta.joins(:lancamentos).where("transferencia_id = ? and tipo = ?  and ativo= ?", @transferencia.id, 'Débito', true).take
    set_transferencia
    deb = Lancamento.find(@transferencia.debito_id)
    cred = Lancamento.find(@transferencia.credito_id)
    @con_deb = Conta.find(deb.conta_id)
    @con_cred = Conta.find(cred.conta_id)
  end


  # POST /transferencias
  # POST /transferencias.json


  # PATCH/PUT /transferencias/1
  # PATCH/PUT /transferencias/1.json



  def create
    @transferencia = Transferencia.new(transferencia_params)

    respond_to do |format|
      if @transferencia.save
        if @transferencia.credito_id == @transferencia.debito_id
          @transferencia.destroy
          format.html { redirect_to transferencias_path, notice: "Você não pode fazer transferencias para duas contas iguais" }
        else
          cria_debito
          cria_credito


          format.html { redirect_to @transferencia, notice: 'Transferência criada com sucesso .' }
          format.json { render :show, status: :created, location: @transferencia }
        end
      else
        format.html { render :new }
        format.json { render json: @transferencia.errors, status: :unprocessable_entity }
      end
    end
  end



  def update
    respond_to do |format|

      debito_id_orig = @transferencia.debito_id
      credito_id_orig = @transferencia.credito_id

      if @transferencia.update_attributes(transferencia_params)
          contadebito = @transferencia.debito_id
          contacredito = @transferencia.credito_id
          @transferencia.debito_id = debito_id_orig
          @transferencia.credito_id = credito_id_orig
          @transferencia.save
          editadebito(contadebito)
          editacredito(contacredito)
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

    if @transferencia.transf_multipla == true
      tm_id = @transferencia.transf_multipla_id
      transfs = Transferencia.where(transf_multipla_id: tm_id)
      transfs.each do |tr|
        tr.destroy
      end
      lancs = Lancamento.where(transf_multipla_id: tm_id)
      lancs.each do |lan|
        lan.destroy
      end
    else
      @transferencia.destroy
    end

    respond_to do |format|
      if @transferencia.transf_multipla == true
        format.html { redirect_to transferencias_url, notice: 'Transferências apagadas com sucesso.' }
      else
        format.html { redirect_to transferencias_url, notice: 'Transferência apagada com sucesso.' }
      end
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
      params.require(:transferencia).permit(:data, :datadocumento, :debito_id, :credito_id, :valor, :observacao, :fornecedor_id, :num_notafiscal, :empenho, :porcentagem,  :transf_multipla, :valor_deb_orig, :transf_multipla_id)
    end
end
