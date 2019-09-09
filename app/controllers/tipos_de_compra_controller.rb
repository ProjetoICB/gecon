class TiposDeCompraController < ApplicationController
  before_filter 'autenticado?'
  before_action :set_tipo_de_compra, only: [:show, :edit, :update, :destroy, :desativa_tipodecompra]

  # GET /tipos_de_compra
  # GET /tipos_de_compra.json
  def index
    @tipos_de_compra = TipoDeCompra.where(ativo: true)
  end

  # GET /tipos_de_compra/1
  # GET /tipos_de_compra/1.json
  def show
  end

  # GET /tipos_de_compra/new
  def new
    @tipo_de_compra = TipoDeCompra.new
  end

  # GET /tipos_de_compra/1/edit
  def edit
  end

  # POST /tipos_de_compra
  # POST /tipos_de_compra.json
  def create
    @tipo_de_compra = TipoDeCompra.new(tipo_de_compra_params)

    respond_to do |format|
      if @tipo_de_compra.save
        format.html { redirect_to @tipos_de_compra, notice: 'Tipo de compra criado com sucesso.' }
        format.json { render :show, status: :created, location: @tipo_de_compra }
      else
        format.html { render :new }
        format.json { render json: @tipo_de_compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipos_de_compra/1
  # PATCH/PUT /tipos_de_compra/1.json
  def update
    respond_to do |format|
      if @tipo_de_compra.update(tipo_de_compra_params)
        format.html { redirect_to @tipo_de_compra, notice: 'Tipo de compra atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @tipo_de_compra }
      else
        format.html { render :edit }
        format.json { render json: @tipo_de_compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipos_de_compra/1
  # DELETE /tipos_de_compra/1.json
  def destroy
    @tipo_de_compra.destroy
    respond_to do |format|
      format.html { redirect_to tipos_de_compra_url, notice: 'Tipo de compra apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def desativa_tipodecompra
    @tipo_de_compra.ativo = false
    @tipo_de_compra.save
    respond_to do |format|
      format.html { redirect_to tipos_de_compra_path, notice: "Tipo de compra desativada com sucesso" }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_de_compra
      @tipo_de_compra = TipoDeCompra.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_de_compra_params
      params.require(:tipo_de_compra).permit(:nome)
    end
end
