module ApplicationHelper

  def find_item(item_id)
    Item.find(item_id)
  end

  def calculate_subtotal(price, quantity)
    number_to_currency(price * quantity)
  end

  def all_categories
    Category.all
  end

end
