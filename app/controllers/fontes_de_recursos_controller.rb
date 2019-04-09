class FontesDeRecursosController < ApplicationController
  before_action :set_fonte_de_recursos, only: [:show, :edit, :update, :destroy]

  # GET /fontes_de_recursos
  # GET /fontes_de_recursos.json
  def index
    @fontes_de_recursos = FonteDeRecursos.all
  end

  # GET /fontes_de_recursos/1
  # GET /fontes_de_recursos/1.json
  def show
  end

  # GET /fontes_de_recursos/new
  def new
    @fonte_de_recursos = FonteDeRecursos.new
  end

  # GET /fontes_de_recursos/1/edit
  def edit
  end

  # POST /fontes_de_recursos
  # POST /fontes_de_recursos.json
  def create
    @fonte_de_recursos = FonteDeRecursos.new(fonte_de_recursos_params)

    respond_to do |format|
      if @fonte_de_recursos.save
        format.html { redirect_to @fonte_de_recursos, notice: 'Fonte de recurso criada com sucesso.' }
        format.json { render :show, status: :created, location: @fonte_de_recursos }
      else
        format.html { render :new }
        format.json { render json: @fonte_de_recursos.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fontes_de_recursos/1
  # PATCH/PUT /fontes_de_recursos/1.json
  def update
    respond_to do |format|
      if @fonte_de_recursos.update(fonte_de_recursos_params)
        format.html { redirect_to @fonte_de_recursos, notice: 'Fonte de recurso atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @fonte_de_recursos }
      else
        format.html { render :edit }
        format.json { render json: @fonte_de_recursos.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fontes_de_recursos/1
  # DELETE /fontes_de_recursos/1.json
  def destroy
    @fonte_de_recursos.destroy
    respond_to do |format|
      format.html { redirect_to fontes_de_recursos_url, notice: 'Fonte de recurso apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fonte_de_recursos
      @fonte_de_recursos = FonteDeRecursos.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fonte_de_recursos_params
      params.require(:fonte_de_recursos).permit(:nome)
    end
end
