class Admin::HomesController < ApplicationController
  def top
    path = Rails.application.routes.recognize_path(request.referer)
    
    if path[:controller] == "admin/orders" && path[:action] == "show"
      order = Order.find_by(id: path[:id])
      @orders = Order.where(customer_id: order.customer_id)
    else
      @orders = Order.all
    end
  end
  
end
