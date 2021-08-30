class Admin::HomesController < ApplicationController
  def top
    path = Rails.application.routes.recognize_path(request.referer)
    
    if path[:controller] == "admin/orders" && path[:action] == "show"
      order = Order.find_by(id: path[:id])
      @orders = Order.where(customer_id: order.customer_id).page(params[:page]).reverse_order
    elsif 
      path[:controller] == "admin/customers" && path[:action] == "show"
      @orders = Order.where(customer_id: path[:id]).page(params[:page]).reverse_order
    else
      @orders = Order.page(params[:page]).reverse_order
    end
  end
  
end
