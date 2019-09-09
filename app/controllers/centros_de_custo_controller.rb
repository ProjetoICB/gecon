class CentrosDeCustoController < ApplicationController
  before_filter 'autenticado?'
  before_action :set_centro_de_custo, only: [:show, :edit, :update, :destroy, :desativa_centrodecusto]

  # GET /centros_de_custo
  # GET /centros_de_custo.json
  def index
    @centros_de_custo = CentroDeCusto.where(ativo: true)
  end

  # GET /centros_de_custo/1
  # GET /centros_de_custo/1.json
  def show
  end

  # GET /centros_de_custo/new
  def new
    @centro_de_custo = CentroDeCusto.new
  end

  # GET /centros_de_custo/1/edit
  def edit
  end

  # POST /centros_de_custo
  # POST /centros_de_custo.json
  def create
    @centro_de_custo = CentroDeCusto.new(centro_de_custo_params)

    respond_to do |format|
      if @centro_de_custo.save
        addlog('Criou novo centro de custo')
        format.html { redirect_to @centro_de_custo, notice: 'Centro de custo foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @centro_de_custo }
      else
        format.html { render :new }
        format.json { render json: @centro_de_custo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /centros_de_custo/1
  # PATCH/PUT /centros_de_custo/1.json
  def update
    respond_to do |format|
      if @centro_de_custo.update(centro_de_custo_params)
        format.html { redirect_to @centro_de_custo, notice: 'Centro de custo foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @centro_de_custo }
      else
        format.html { render :edit }
        format.json { render json: @centro_de_custo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /centros_de_custo/1
  # DELETE /centros_de_custo/1.json
  def destroy
    @centro_de_custo.destroy
    respond_to do |format|
      format.html { redirect_to centros_de_custo_url, notice: 'Centro de custo foi apaggado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def desativa_centrodecusto
    @centro_de_custo.ativo = false
    @centro_de_custo.save
    respond_to do |format|
      format.html { redirect_to centros_de_custo_path, notice:  "Centro de custo desativado com sucesso"}
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_centro_de_custo
      @centro_de_custo = CentroDeCusto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def centro_de_custo_params
      params.require(:centro_de_custo).permit(:nome, :ativo)
    end
end
