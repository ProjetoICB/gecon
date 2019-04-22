class ItensDeDespesaController < ApplicationController
  before_filter 'autenticado?'
  before_action :set_item_de_despesa, only: [:show, :edit, :update, :destroy]

  # GET /itens_de_despesa
  # GET /itens_de_despesa.json
  def index
    @itens_de_despesa = ItemDeDespesa.all
  end

  # GET /itens_de_despesa/1
  # GET /itens_de_despesa/1.json
  def show
  end

  # GET /itens_de_despesa/new
  def new
    @item_de_despesa = ItemDeDespesa.new
  end

  # GET /itens_de_despesa/1/edit
  def edit
  end

  # POST /itens_de_despesa
  # POST /itens_de_despesa.json
  def create
    @item_de_despesa = ItemDeDespesa.new(item_de_despesa_params)

    respond_to do |format|
      if @item_de_despesa.save
        format.html { redirect_to @item_de_despesa, notice: 'Item de despesa criado com sucesso.' }
        format.json { render :show, status: :created, location: @item_de_despesa }
      else
        format.html { render :new }
        format.json { render json: @item_de_despesa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /itens_de_despesa/1
  # PATCH/PUT /itens_de_despesa/1.json
  def update
    respond_to do |format|
      if @item_de_despesa.update(item_de_despesa_params)
        format.html { redirect_to @item_de_despesa, notice: 'Item de despesa was alterado com sucesso.' }
        format.json { render :show, status: :ok, location: @item_de_despesa }
      else
        format.html { render :edit }
        format.json { render json: @item_de_despesa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itens_de_despesa/1
  # DELETE /itens_de_despesa/1.json
  def destroy
    @item_de_despesa.destroy
    respond_to do |format|
      format.html { redirect_to itens_de_despesa_url, notice: 'Item de despesa apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_de_despesa
      @item_de_despesa = ItemDeDespesa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_de_despesa_params
      params.require(:item_de_despesa).permit(:nomeGecon, :nome, :codigitado)
    end
end
