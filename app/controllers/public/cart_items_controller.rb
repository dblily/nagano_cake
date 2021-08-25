class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end
  
  def create
    if params[:cart_item][:amount].present?
    
      if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) 
        cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        cart_item.amount += params[:cart_item][:amount].to_i
      else
        cart_item = CartItem.new(cart_item_params)
      end
    
      cart_item.customer_id = current_customer.id
      cart_item.save
      redirect_to cart_items_path, notice: 'successfully'
      
    else
      redirect_to item_path(params[:cart_item][:item_id]), alert: '個数を選択してください'
    end
  end
  
  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path, notice: 'successfully'
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  private
    def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
    end
  
end
