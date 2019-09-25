class LancamentosController < ApplicationController
  before_action :set_lancamento, only: [:show, :edit, :update, :destroy]


  def debito_multiplo

  end

  def gera_debito_multiplo
    data= params[:data]
    datadocumento= params[:datadocumento]
    processo= params[:processo]
    credito_id= params[:credito_id]
    item_de_despesa= params[:item_de_despesa_id]
    item_de_receita= params[:item_de_receita_id]
    tipo_de_compra= params[:tipo_de_compra_id]
    nota_fiscal= params[:num_notafiscal]
    empenho= params[:empenho]
    observacao = params[:observacao]
    d1 = params[:d1]
    d2 = params[:d2]
    d3 = params[:d3]
    d4 = params[:d4]
    d5 = params[:d5]
    d6 = params[:d6]
    d7 = params[:d7]
    d8 = params[:d8]
    v1 = params[:valor1].to_f
    v2 = params[:valor2].to_f
    v3 = params[:valor3].to_f
    v4 = params[:valor4].to_f
    v5 = params[:valor5].to_f
    v6 = params[:valor6].to_f
    v7 = params[:valor7].to_f
    v8 = params[:valor8].to_f
    @parar = "N"


    todos = [d1,d2,d3,d4,d5,d6,d7,d8]
    valores = [v1,v2,v3,v4,v5,v6,v7,v8]
    todos.each do |t|
     if t == credito_id
        @parar = "S"
        break
      end
    end

    a1 = [d2,d3,d4,d5,d6,d7,d8]
    a1.each do |a|
      if d1 == a
        @parar = "S"
        break
      end
    end

    a2 = [d3,d4,d5,d6,d7,d8]
    a2.each do |a|
      if d2 == a
        @parar = "S"
        break
      end
    end

    a3=[d4,d5,d6,d7,d8]
    a3.each do |a|
      if d3 == a
        @parar = "S"
        break
      end
    end

    a4=[d5,d6,d7,d8]
    a4.each do |a|
      if d4 == a
        @parar = "S"
        break
      end
    end

    a5=[d6,d7,d8]
    a5.each do |a|
      if d5 == a
        @parar = "S"
        break
      end
    end

    a6=[d7,d8]
    a6.each do |a|
      if d6 == a
        @parar = "S"
        break
      end
    end

    if d7 == d8
      @parar = "S"
    end

    # aqui vai entrar a logica da criação do lançamento multipço
    if @parar == "S"
      redirect_to lancamentos_path(:atual => "Sim"), notice: "Impossível fazer esse lançamento multiplo. Contas de débito e/ou credito repetidas"
    else
      # esse trecho até o end vai criar os registros de CREDITO
      valores.each do |v|
        lc=Lancamento.new
        lc.data = data
        lc.datadocumento = datadocumento
        lc.processo = processo
        lc.conta_id = credito_id
        lc.item_de_receita_id = item_de_receita
        lc.tipo = "Crédito"
        lc.tipo_de_compra_id = tipo_de_compra
        lc.num_notafiscal = nota_fiscal
        lc.empenho = empenho
        lc.observacao = observacao
        lc.credito = v
        lc.save
      end


      # A partir daqui são criados os registros de débito
      ld=Lancamento.new
      ld.data = data
      ld.datadocumento = datadocumento
      ld.processo = processo
      ld.conta_id = d1
      ld.item_de_despesa_id = item_de_despesa
      ld.tipo = "Débito"
      ld.tipo_de_compra_id = tipo_de_compra
      ld.num_notafiscal = nota_fiscal
      ld.empenho = empenho
      ld.observacao = observacao
      ld.debito = v1
      ld.save


      ld=Lancamento.new
      ld.data = data
      ld.datadocumento = datadocumento
      ld.processo = processo
      ld.conta_id = d2
      ld.item_de_despesa_id = item_de_despesa
      ld.tipo = "Débito"
      ld.tipo_de_compra_id = tipo_de_compra
      ld.num_notafiscal = nota_fiscal
      ld.empenho = empenho
      ld.observacao = observacao
      ld.debito = v2
      ld.save


      ld=Lancamento.new
      ld.data = data
      ld.datadocumento = datadocumento
      ld.processo = processo
      ld.conta_id = d3
      ld.item_de_despesa_id = item_de_despesa
      ld.tipo = "Débito"
      ld.tipo_de_compra_id = tipo_de_compra
      ld.num_notafiscal = nota_fiscal
      ld.empenho = empenho
      ld.observacao = observacao
      ld.debito = v3
      ld.save


      ld=Lancamento.new
      ld.data = data
      ld.datadocumento = datadocumento
      ld.processo = processo
      ld.conta_id = d4
      ld.item_de_despesa_id = item_de_despesa
      ld.tipo = "Débito"
      ld.tipo_de_compra_id = tipo_de_compra
      ld.num_notafiscal = nota_fiscal
      ld.empenho = empenho
      ld.observacao = observacao
      ld.debito = v4
      ld.save


      ld=Lancamento.new
      ld.data = data
      ld.datadocumento = datadocumento
      ld.processo = processo
      ld.conta_id = d5
      ld.item_de_despesa_id = item_de_despesa
      ld.tipo = "Débito"
      ld.tipo_de_compra_id = tipo_de_compra
      ld.num_notafiscal = nota_fiscal
      ld.empenho = empenho
      ld.observacao = observacao
      ld.debito = v5
      ld.save


      ld=Lancamento.new
      ld.data = data
      ld.datadocumento = datadocumento
      ld.processo = processo
      ld.conta_id = d6
      ld.item_de_despesa_id = item_de_despesa
      ld.tipo = "Débito"
      ld.tipo_de_compra_id = tipo_de_compra
      ld.num_notafiscal = nota_fiscal
      ld.empenho = empenho
      ld.observacao = observacao
      ld.debito = v6
      ld.save


      ld=Lancamento.new
      ld.data = data
      ld.datadocumento = datadocumento
      ld.processo = processo
      ld.conta_id = d7
      ld.item_de_despesa_id = item_de_despesa
      ld.tipo = "Débito"
      ld.tipo_de_compra_id = tipo_de_compra
      ld.num_notafiscal = nota_fiscal
      ld.empenho = empenho
      ld.observacao = observacao
      ld.debito = v7
      ld.save


      ld=Lancamento.new
      ld.data = data
      ld.datadocumento = datadocumento
      ld.processo = processo
      ld.conta_id = d8
      ld.item_de_despesa_id = item_de_despesa
      ld.tipo = "Débito"
      ld.tipo_de_compra_id = tipo_de_compra
      ld.num_notafiscal = nota_fiscal
      ld.empenho = empenho
      ld.observacao = observacao
      ld.debito = v8
      ld.save
      redirect_to lancamentos_path(:atual => "Sim"), notice: "Lançamentos criados com sucesso"
    end
  end

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
    at = params[:atual]
    if at == "Sim"
      @lancamentos = Lancamento.where("year(created_at) = ?", Date.today.year).order("id desc")
    else
      @lancamentos = Lancamento.all.order("id desc")
    end
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
      params.require(:lancamento).permit(:processo, :data, :datadocumento, :observacao, :debito, :credito, :tipo, :conta_id, :fornecedor_id, :item_de_despesa_id, :item_de_receita_id, :tipo_de_compra_id, :debito_cancelado, :retorno_debitocanc, :num_notafiscal, :empenho, :atual)
    end
end
