class FoodTruck
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, num_of_items)
    @inventory[item] += num_of_items
  end

  def potential_revenue
    @inventory.sum do |item, num_of_items|
      item.price * num_of_items
    end
  end

end
