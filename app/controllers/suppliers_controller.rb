class SuppliersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_supplier, only: [:edit, :update, :show]
  
  def index
    @suppliers = Supplier.all
  end

  def show;  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      redirect_to @supplier, notice: 'Fornecedor cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Fornecedor não cadastrado.'
      render 'new'
    end
  end

  def update
    supplier_params
      if @supplier.update(supplier_params)
        redirect_to @supplier, notice: "Fornecedor atualizado com sucesso!"
      else
        flash[:alert] = 'Não foi possível atualizar o fornecedor.'
        render 'edit'
      end
  end

  def edit;  end

  def new
    @supplier = Supplier.new
  end

  def show; end
  
  


  private
  def set_supplier 
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city,
      :state, :email)
  end
end