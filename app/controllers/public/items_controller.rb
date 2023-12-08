class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.only_active
    if params[:genre_id]
      @genre = @genres.find(params[:genre_id])
      all_items = @genre.items
    else
      all_items = Item.where_genre_active
    end
    active_all_items = all_items.only_active.includes(:genre)
    @items = active_all_items.page(params[:page]).per(12)
    @all_items_count = active_all_items.count
  end

  def show
    @item = Item.where_genre_active.find(params[:id])
    @genres = Genre.only_active
    @cart_item = CartItem.new
  end
end
