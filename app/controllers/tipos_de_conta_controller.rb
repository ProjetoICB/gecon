class TiposDeContaController < ApplicationController
  before_filter 'autenticado?'
  before_action :set_tipo_de_conta, only: [:show, :edit, :update, :destroy]

  # GET /tipos_de_conta
  # GET /tipos_de_conta.json
  def index
    @tipos_de_conta = TipoDeConta.all
  end

  # GET /tipos_de_conta/1
  # GET /tipos_de_conta/1.json
  def show
  end

  # GET /tipos_de_conta/new
  def new
    @tipo_de_conta = TipoDeConta.new
  end

  # GET /tipos_de_conta/1/edit
  def edit
  end

  # POST /tipos_de_conta
  # POST /tipos_de_conta.json
  def create
    @tipo_de_conta = TipoDeConta.new(tipo_de_conta_params)

    respond_to do |format|
      if @tipo_de_conta.save
        format.html { redirect_to @tipo_de_conta, notice: 'Tipo de conta criado com sucesso' }
        format.json { render :show, status: :created, location: @tipo_de_conta }
      else
        format.html { render :new }
        format.json { render json: @tipo_de_conta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipos_de_conta/1
  # PATCH/PUT /tipos_de_conta/1.json
  def update
    respond_to do |format|
      if @tipo_de_conta.update(tipo_de_conta_params)
        format.html { redirect_to @tipo_de_conta, notice: 'Tipo de atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @tipo_de_conta }
      else
        format.html { render :edit }
        format.json { render json: @tipo_de_conta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipos_de_conta/1
  # DELETE /tipos_de_conta/1.json
  def destroy
    @tipo_de_conta.destroy
    respond_to do |format|
      format.html { redirect_to tipos_de_conta_url, notice: 'Tipo de conta apagado com sucesso' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_de_conta
      @tipo_de_conta = TipoDeConta.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_de_conta_params
      params.require(:tipo_de_conta).permit(:nome, :grupo_id)
    end
end
