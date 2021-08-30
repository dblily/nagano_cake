class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items
      @name = @genre.name
      @count = @items.count
    else
      @items = Item.all
      @name = "商品"
      @count = @items.count
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    
    @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items
      @name = @genre.name
      @count = @items.count
    else
      @items = Item.all
      @name = "商品"
      @count = @items.count
    end
  end
  
  def search
    @items = Item.search(params[:keyword])
  end
  
end
