class ItensDeReceitaController < ApplicationController
  before_filter 'autenticado?'
  before_action :set_item_de_receita, only: [:show, :edit, :update, :destroy, :desativa_item_receita]

  # GET /itens_de_receita
  # GET /itens_de_receita.json
  def index
    @itens_de_receita = ItemDeReceita.where(ativo: true)
  end

  # GET /itens_de_receita/1
  # GET /itens_de_receita/1.json
  def show
  end

  # GET /itens_de_receita/new
  def new
    @item_de_receita = ItemDeReceita.new
  end

  # GET /itens_de_receita/1/edit
  def edit
  end

  # POST /itens_de_receita
  # POST /itens_de_receita.json
  def create
    @item_de_receita = ItemDeReceita.new(item_de_receita_params)

    respond_to do |format|
      if @item_de_receita.save
        format.html { redirect_to @item_de_receita, notice: 'Item de receita criado com sucesso.' }
        format.json { render :show, status: :created, location: @item_de_receita }
      else
        format.html { render :new }
        format.json { render json: @item_de_receita.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /itens_de_receita/1
  # PATCH/PUT /itens_de_receita/1.json
  def update
    respond_to do |format|
      if @item_de_receita.update(item_de_receita_params)
        format.html { redirect_to @item_de_receita, notice: 'Item de receita atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @item_de_receita }
      else
        format.html { render :edit }
        format.json { render json: @item_de_receita.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itens_de_receita/1
  # DELETE /itens_de_receita/1.json
  def destroy
    @item_de_receita.destroy
    respond_to do |format|
      format.html { redirect_to itens_de_receita_url, notice: 'Item de receita apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def desativa_item_receita
    @item_de_receita.ativo = false
    @item_de_receita.save
    respond_to do |format|
      format.html { redirect_to itens_de_despesa_path, notice: 'Item de receita desativado com sucesso'  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_de_receita
      @item_de_receita = ItemDeReceita.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_de_receita_params
      params.require(:item_de_receita).permit(:nomeGecon, :nome, :coddigitado)
    end
end
