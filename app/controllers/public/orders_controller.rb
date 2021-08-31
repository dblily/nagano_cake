class Public::OrdersController < ApplicationController
  def index
    @orders = Order.where(customer_id: current_customer.id)
  end
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end
  
  def new
    @customer = current_customer
    @order = Order.new
  end
  
  def comfirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order = Order.new(order_params)
    @shipping_cost = 800
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
  end
  
  def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.save 
    
    cart_items = current_customer.cart_items
      cart_items.each do |cart_item|
        order_item = OrderItem.new
        order_item.item_id = cart_item.item_id
        order_item.order_id = order.id
        order_item.price = cart_item.item.add_tax_price
        order_item.amount = cart_item.amount
        order_item.save
      end
      current_customer.cart_items.destroy_all
      redirect_to orders_thanks_path
  end
  
  def thanks
  end
  
  private
    def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end
end
