module ApplicationHelper

  def find_item(item_id)
    Item.find(item_id)
  end

  def convert_to_currency(total_price)
    number_to_currency(total_price)
  end

  def calculate_subtotal(price, quantity)
    number_to_currency(price * quantity)
  end

end
