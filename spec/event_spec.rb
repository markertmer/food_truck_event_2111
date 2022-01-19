require './spec/spec_helper.rb'

describe Event do
  describe 'Iteration 2' do
    before(:each) do
      @event = Event.new("South Pearl Street Farmers Market")

      @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
      @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
      @food_truck3 = FoodTruck.new("Palisade Peach Shack")

      @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
      @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)

      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)

      @food_truck3.stock(@item1, 65)
    end

    it 'exists' do
      expect(@event).to be_instance_of Event
    end

    it 'has a name' do
      expect(@event.name).to eq "South Pearl Street Farmers Market"
    end

    it 'starts with no food trucks' do
      expect(@event.food_trucks).to eq []
    end

    it 'can add food trucks' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)

      expect(@event.food_trucks).to eq [@food_truck1, @food_truck2, @food_truck3]
    end

    it 'names all of its food trucks' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_truck_names).to eq ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    end

    it 'finds the food trucks that sell a certain item' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_trucks_that_sell(@item1)).to eq [@food_truck1, @food_truck3]
      expect(@event.food_trucks_that_sell(@item4)).to eq [@food_truck2]
    end
  end

  describe 'Iteration 3' do
    before(:each) do
      @event = Event.new("South Pearl Street Farmers Market")

      @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
      @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
      @food_truck3 = FoodTruck.new("Palisade Peach Shack")

      @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
      @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)

      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)

      @food_truck3.stock(@item1, 65)
      @food_truck3.stock(@item3, 10)

      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
    end

    it 'finds the total inventory' do
      expected = {
        @item1 => {quantity: 100, food_trucks: [@food_truck1, @food_truck3]},
        @item2 => {quantity: 7, food_trucks: [@food_truck1]},
        @item3 => {quantity: 35, food_trucks: [@food_truck2, @food_truck3]},
        @item4 => {quantity: 50, food_trucks: [@food_truck2]}
      }
      expect(@event.total_inventory).to eq expected
    end

    it 'finds overstocked items' do
      expect(@event.overstocked_items).to eq [@item1]
    end

    it 'generates an alphabetical list of all items' do
      expected = [
        "Apple Pie (Slice)",
        "Banana Nice Cream",
        "Peach Pie (Slice)",
        "Peach-Raspberry Nice Cream"
      ]
      expect(@event.sorted_item_list).to eq expected
    end

  end
end
