class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end
  
  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.customer_id = current_customer.id
    if cart_item.save
      redirect_to cart_items_path, notice: 'successfully'
    else
      @item = Item.find(params[:id])
      render item_path(cart_item)
    end
  end
  
  def update
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
