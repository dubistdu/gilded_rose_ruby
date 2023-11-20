require './item/item.rb'
class AgedBrie < Item
  AGED_BRIE = "Aged Brie"

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def aged_brie
    @name == AGED_BRIE
  end

  def handle_aged_brie
    increase_quality
    decrease_sell_in
    if @sell_in < 0 && @quality < 50
      increase_quality
    end
  end
end
