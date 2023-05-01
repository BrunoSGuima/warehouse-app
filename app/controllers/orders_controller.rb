class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_check_user, only: [:show, :edit, :update]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: "Pedido registrado com sucesso."
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert] = 'Pedido não registrado.'
      render :new
    end
  end

  def show
  end

  def search
    @code = params["query"]
    @orders = Order.where("code LIKE?", "%#{@code}%")
  end
  
  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    order_params
    @order.update(order_params)
    redirect_to @order, notice: 'Pedido atualizado com sucesso.'
  end
  
  
  
  private
  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end

  def set_order_check_user
  @order = Order.find(params[:id])
    if @order.user !=current_user
      return redirect_to root_path, alert: 'Você não possui acesso a este pedido.'
    end
  end


end