class FornecedoresController < ApplicationController
  before_filter 'autenticado?'
  before_action :set_fornecedor, only: [:show, :edit, :update, :destroy,:desativa_fornecedor]

  # GET /fornecedores
  # GET /fornecedores.json
  def index
    @fornecedores = Fornecedor.order("nome")
  end

  # GET /fornecedores/1
  # GET /fornecedores/1.json
  def show
  end

  # GET /fornecedores/new
  def new
    @fornecedor = Fornecedor.new
  end

  # GET /fornecedores/1/edit
  def edit
  end

  # POST /fornecedores
  # POST /fornecedores.json
  def create
    @fornecedor = Fornecedor.new(fornecedor_params)

    respond_to do |format|
      if @fornecedor.save
        addlog("Fornecedor criado")
        format.html { redirect_to @fornecedor, notice: 'Fornecedor criado com sucesso.' }
        format.json { render :show, status: :created, location: @fornecedor }
      else
        format.html { render :new }
        format.json { render json: @fornecedor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fornecedores/1
  # PATCH/PUT /fornecedores/1.json
  def update
    respond_to do |format|
      if @fornecedor.update(fornecedor_params)
        addlog("Fornecedor atualizado")
        format.html { redirect_to @fornecedor, notice: 'Fornecedor atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @fornecedor }
      else
        format.html { render :edit }
        format.json { render json: @fornecedor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fornecedores/1
  # DELETE /fornecedores/1.json
  def destroy
    @fornecedor.destroy
    addlog("Fornecedor apagado")
    respond_to do |format|
      format.html { redirect_to fornecedores_url, notice: 'Fornecedor apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def desativa_fornecedor
    @fornecedor.ativo = false
    @fornecedor.save
    addlog("Fornecedor desativado")
    respond_to do  |format|
      format.html { redirect_to fornecedores_path, notice: "Fornecedor desativado com sucesso"  }
      format.json { head :no_content  }
    end
  end

  def ativa_fornecedor
    set_fornecedor
    @fornecedor.ativo = true
    @fornecedor.save
    addlog("Fornecedor ativado")
    respond_to do  |format|
      format.html { redirect_to fornecedores_path, notice: "Fornecedor ativado com sucesso"  }
      format.json { head :no_content  }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fornecedor
      @fornecedor = Fornecedor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fornecedor_params
      params.require(:fornecedor).permit(:nome)
    end
end
