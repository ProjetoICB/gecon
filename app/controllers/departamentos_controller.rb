class DepartamentosController < ApplicationController
  before_filter 'autenticado?'
  before_action :set_departamento, only: [:show, :edit, :update, :destroy, :desativa_departamento]

  # GET /departamentos
  # GET /departamentos.json
  def index
    @departamentos = Departamento.all
  end

  # GET /departamentos/1
  # GET /departamentos/1.json
  def show
  end

  # GET /departamentos/new
  def new
    @departamento = Departamento.new
  end

  # GET /departamentos/1/edit
  def edit
  end

  # POST /departamentos
  # POST /departamentos.json
  def create
    @departamento = Departamento.new(departamento_params)

    respond_to do |format|
      if @departamento.save
        addlog("Criou um departamento")
        format.html { redirect_to @departamento, notice: 'Departamento criado com sucesso.' }
        format.json { render :show, status: :created, location: @departamento }
      else
        format.html { render :new }
        format.json { render json: @departamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departamentos/1
  # PATCH/PUT /departamentos/1.json
  def update
    respond_to do |format|
      if @departamento.update(departamento_params)
        addlog("Atualizou um departamento")
        format.html { redirect_to @departamento, notice: 'Departamento atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @departamento }
      else
        format.html { render :edit }
        format.json { render json: @departamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departamentos/1
  # DELETE /departamentos/1.json
  def destroy
    @departamento.destroy
    addlog("Apagou um departamento")
    respond_to do |format|
      format.html { redirect_to departamentos_url, notice: 'Departamento apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def desativa_departamento
    @departamento.ativo =  false
    @departamento.save
    addlog("Desativou um departamento")
    respond_to do |format|
      format.html { redirect_to departamentos_path, notice: "Departamento desativado com sucesso"  }
      format.json { head :no_content }
    end
  end


  def ativa_departamento
    set_departamento
    @departamento.ativo =  true
    @departamento.save
    addlog("Ativou um departamento")
    respond_to do |format|
      format.html { redirect_to departamentos_path, notice: "Departamento ativado com sucesso"  }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departamento
      @departamento = Departamento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def departamento_params
      params.require(:departamento).permit(:nome, :sigla)
    end
end
