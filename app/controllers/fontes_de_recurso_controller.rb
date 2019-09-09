class FontesDeRecursoController < ApplicationController
  before_filter 'autenticado?'
  before_action :set_fonte_de_recurso, only: [:show, :edit, :update, :destroy, :desativa_fontederecurso]

  # GET /fontes_de_recurso
  # GET /fontes_de_recurso.json
  def index
    @fontes_de_recurso = FonteDeRecurso.where(ativo: true)
  end

  # GET /fontes_de_recurso/1
  # GET /fontes_de_recurso/1.json
  def show
  end

  # GET /fontes_de_recurso/new
  def new
    @fonte_de_recurso = FonteDeRecurso.new
  end

  # GET /fontes_de_recurso/1/edit
  def edit
  end

  # POST /fontes_de_recurso
  # POST /fontes_de_recurso.json
  def create
    @fonte_de_recurso = FonteDeRecurso.new(fonte_de_recurso_params)

    respond_to do |format|
      if @fonte_de_recurso.save
        format.html { redirect_to @fonte_de_recurso, notice: 'Fonte de recurso criado com sucesso.' }
        format.json { render :show, status: :created, location: @fonte_de_recurso }
      else
        format.html { render :new }
        format.json { render json: @fonte_de_recurso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fontes_de_recurso/1
  # PATCH/PUT /fontes_de_recurso/1.json
  def update
    respond_to do |format|
      if @fonte_de_recurso.update(fonte_de_recurso_params)
        format.html { redirect_to @fonte_de_recurso, notice: 'Fonte de recurso atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @fonte_de_recurso }
      else
        format.html { render :edit }
        format.json { render json: @fonte_de_recurso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fontes_de_recurso/1
  # DELETE /fontes_de_recurso/1.json
  def destroy
    @fonte_de_recurso.destroy
    respond_to do |format|
      format.html { redirect_to fontes_de_recurso_url, notice: 'Fonte de recurso apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def desativa_fontederecurso
    @fonte_de_recurso.ativo = false
    @fonte_de_recurso.save
    respond_to do |format|
      format.html { redirect_to fontes_de_recurso_path, notice: "Fonte de recurso desatuvada com sucesso" }
      format.json { head :no_content}
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fonte_de_recurso
      @fonte_de_recurso = FonteDeRecurso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fonte_de_recurso_params
      params.require(:fonte_de_recurso).permit(:nome)
    end
end
