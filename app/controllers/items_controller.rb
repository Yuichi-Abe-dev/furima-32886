class ItemsController < ApplicationController
  #before_action :authenticate_user!, except:

  def new
    @items = Item.new
  end

end
