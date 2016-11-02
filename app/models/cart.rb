class Cart

  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end

  def total_items
    contents.values.sum
  end

  def total_price
    @contents.reduce(0) do |result, (item_id, quantity)|
      item = Item.find(item_id)
      result += item.price * quantity
      result
    end
  end

  def decrease_item(item_id)
    contents[item_id.to_s] -= 1
    contents.delete(item_id.to_s) if contents[item_id.to_s] == 0
  end

  def remove_item(item_id)
    contents.delete(item_id.to_s)
  end


end
