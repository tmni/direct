class CartsController < ApplicationController
  include Cart

  def index
    @items = session[:cart]
    @total = calculate_total_cost
  end

  def create
    if params[:barcode_id]
      session[:cart].each do |c| #check for each item in cart

        return if c['barcode_id'] == params[:barcode_id].to_i #for loop??
      end
      puts params[:barcode_id]
      item = Item.find_by(barcode_id: params[:barcode_id])
      ci = add_to_cart(session[:rows], item.item_name, item.price, item.barcode_id)
      ci
    end
  end

  def destroy
    remove_from_cart(params[:barcode_id].to_i)
    redirect_to :cart
  end

end