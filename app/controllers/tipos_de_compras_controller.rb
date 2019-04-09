class TiposDeComprasController < ApplicationController
  before_action :set_tipo_de_compras, only: [:show, :edit, :update, :destroy]

  # GET /tipos_de_compras
  # GET /tipos_de_compras.json
  def index
    @tipos_de_compras = TipoDeCompras.all
  end

  # GET /tipos_de_compras/1
  # GET /tipos_de_compras/1.json
  def show
  end

  # GET /tipos_de_compras/new
  def new
    @tipo_de_compras = TipoDeCompras.new
  end

  # GET /tipos_de_compras/1/edit
  def edit
  end

  # POST /tipos_de_compras
  # POST /tipos_de_compras.json
  def create
    @tipo_de_compras = TipoDeCompras.new(tipo_de_compras_params)

    respond_to do |format|
      if @tipo_de_compras.save
        format.html { redirect_to @tipo_de_compras, notice: 'Tipos de compras criado com sucesso.' }
        format.json { render :show, status: :created, location: @tipo_de_compras }
      else
        format.html { render :new }
        format.json { render json: @tipo_de_compras.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipos_de_compras/1
  # PATCH/PUT /tipos_de_compras/1.json
  def update
    respond_to do |format|
      if @tipo_de_compras.update(tipo_de_compras_params)
        format.html { redirect_to @tipo_de_compras, notice: 'Tipos de compras atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @tipo_de_compras }
      else
        format.html { render :edit }
        format.json { render json: @tipo_de_compras.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipos_de_compras/1
  # DELETE /tipos_de_compras/1.json
  def destroy
    @tipo_de_compras.destroy
    respond_to do |format|
      format.html { redirect_to tipos_de_compras_url, notice: 'Tipo de compras atualizado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_de_compras
      @tipo_de_compras = TipoDeCompras.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_de_compras_params
      params.require(:tipo_de_compras).permit(:nome)
    end
end
