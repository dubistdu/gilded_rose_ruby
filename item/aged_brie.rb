require './item/item.rb'
class AgedBrie < Item
  AGED_BRIE = "Aged Brie"

  def aged_brie
    @name == AGED_BRIE
  end

  def handle_item
    increase_quality
    decrease_sell_in
    if @sell_in < 0 && @quality < 50
      increase_quality
    end
    @quality
  end
end
