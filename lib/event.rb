class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map(&:name)
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |food_truck|
      food_truck.inventory[item] > 0
    end
  end

  def total_inventory
    inventory_hash = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, num_of_items|
        if inventory_hash[item]
          inventory_hash[item][:quantity] += num_of_items if inventory_hash[item]
        else
          inventory_hash[item] = {quantity: num_of_items, food_trucks: food_trucks_that_sell(item)}
        end
      end
    end
    inventory_hash
  end

  def sorted_item_list
    item_names = []
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, num_of_items|
        item_names << item.name if num_of_items > 0
      end
    end
    item_names.uniq.sort
  end

  def overstocked_items
    total_inventory.select do |item, hash|
      hash[:quantity] > 50 && hash[:food_trucks].count > 1
    end.keys
  end

end
