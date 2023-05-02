class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_warehouse, only: [:edit, :update, :show, :destroy]
      
  def show
    @stocks = @warehouse.stock_products.group(:product_model).count
  end 

  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_param
    @warehouse = Warehouse.new(warehouse_param  )
    if @warehouse.save
      # flash[:notice] = "Galpão cadastrado com sucesso!"
      redirect_to root_path, notice: "Galpão cadastrado com sucesso!"
    else
      flash.now[:notice] = "Galpão não cadastrado."
      render 'new'
    end
  end 

  def edit
  end

  def update
    warehouse_param
      if @warehouse.update(warehouse_param)
        redirect_to @warehouse, notice: "Galpão atualizado com sucesso!"
      else
        flash[:notice] = "Não foi possível atualizar o galpão."
        render 'edit'
      end
  end

  def destroy
    @warehouse.destroy
    if @warehouse.destroy
      redirect_to root_path, notice: "Galpão removido com sucesso!"
    else
      flash[:notice] = 'Não foi possível remover o galpão'
      render 'show'
    end
  end

  private
  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_param
    params.require(:warehouse).permit(:name, :code, :city, :description, :address,
      :cep, :area) #Strong Parameters
  end 
end