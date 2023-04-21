class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end 

  def new
  end

  def create
    warepara = params.require(:warehouse).permit(:name, :code, :city, :description, :address,
                                                :cep, :area)
    w = Warehouse.new(warepara)
    if w.save
      flash[:notice] = "Galpão cadastrado com sucesso!"
      redirect_to root_path
    else
      flash[:alert] = "Algo deu errado."
      render 'new'
    end
  end   
end



