class ItemsController < ApplicationController

  def new
    @items = Item.new
  end

end
