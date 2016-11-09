class OrderCompletion

  attr_reader :order

  def initialize(order, cart)
    @order = order
    @cart = cart
  end

  def create
    add_items_to_order if !@cart.nil? && !@cart.empty? && @order.save
  end

  def add_items_to_order
    @cart.each do |id, quantity|
      item = Item.find(id)
      add_each_item(quantity, item)
    end
  end

  def add_each_item(quantity, item)
    quantity.times do
      @order.items << item
    end
  end

end
