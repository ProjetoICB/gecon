class CentrosDeCustosController < ApplicationController
  before_action :set_centro_de_custos, only: [:show, :edit, :update, :destroy]

  # GET /centros_de_custos
  # GET /centros_de_custos.json
  def index
    @centros_de_custos = CentroDeCustos.all
  end

  # GET /centros_de_custos/1
  # GET /centros_de_custos/1.json
  def show
  end

  # GET /centros_de_custos/new
  def new
    @centro_de_custos = CentroDeCustos.new
  end

  # GET /centros_de_custos/1/edit
  def edit
  end

  # POST /centros_de_custos
  # POST /centros_de_custos.json
  def create
    @centro_de_custos = CentroDeCustos.new(centro_de_custos_params)

    respond_to do |format|
      if @centro_de_custos.save
        format.html { redirect_to @centro_de_custos, notice: 'Centro de custos criado com sucesso .' }
        format.json { render :show, status: :created, location: @centro_de_custos }
      else
        format.html { render :new }
        format.json { render json: @centro_de_custos.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /centros_de_custos/1
  # PATCH/PUT /centros_de_custos/1.json
  def update
    respond_to do |format|
      if @centro_de_custos.update(centro_de_custos_params)
        format.html { redirect_to @centro_de_custos, notice: 'Centro de custos atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @centro_de_custos }
      else
        format.html { render :edit }
        format.json { render json: @centro_de_custos.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /centros_de_custos/1
  # DELETE /centros_de_custos/1.json
  def destroy
    @centro_de_custos.destroy
    respond_to do |format|
      format.html { redirect_to centros_de_custos_url, notice: 'Centro de custos apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_centro_de_custos
      @centro_de_custos = CentroDeCustos.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def centro_de_custos_params
      params.require(:centro_de_custos).permit(:nome, :ativo)
    end
end
