class GruposController < ApplicationController
  before_filter 'autenticado?'
  before_action :set_grupo, only: [:show, :edit, :update, :destroy, :desativa_grupo]

  # GET /grupos
  # GET /grupos.json
  def index
    @grupos = Grupo.order("coddigitado")
  end

  # GET /grupos/1
  # GET /grupos/1.json
  def show
  end

  # GET /grupos/new
  def new
    @grupo = Grupo.new
  end

  # GET /grupos/1/edit
  def edit
  end

  # POST /grupos
  # POST /grupos.json
  def create
    @grupo = Grupo.new(grupo_params)

    respond_to do |format|
      if @grupo.save
        addlog("Grupo criado")
        format.html { redirect_to @grupo, notice: 'Grupo foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @grupo }
      else
        format.html { render :new }
        format.json { render json: @grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grupos/1
  # PATCH/PUT /grupos/1.json
  def update
    respond_to do |format|
      if @grupo.update(grupo_params)
        addlog("Grupo alterado")
        format.html { redirect_to @grupo, notice: 'Grupo foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @grupo }
      else
        format.html { render :edit }
        format.json { render json: @grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grupos/1
  # DELETE /grupos/1.json
  def destroy
    @grupo.destroy
    addlog("Grupo apagado")
    respond_to do |format|
      format.html { redirect_to grupos_url, notice: 'Grupo foi apagado com sucesso.' }
      format.json { head :no_content }
    end
  end


  def desativa_grupo
    @grupo.ativo = false
    @grupo.save
    addlog("Grupo desativado")
    respond_to do |format|
      format.html { redirect_to grupos_path, notice: "Grupo desativado com sucesso" }
      format.json { head :no_content }
    end
  end


  def ativa_grupo
    set_grupo
    @grupo.ativo = true
    @grupo.save
    addlog("Grupo ativado")
    respond_to do |format|
      format.html { redirect_to grupos_path, notice: "Grupo ativado com sucesso" }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grupo
      @grupo = Grupo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grupo_params
      params.require(:grupo).permit(:nome, :coddigitado)
    end
end
