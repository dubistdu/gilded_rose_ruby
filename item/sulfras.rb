require './item/item.rb'
class Sulfras < Item
  SULFRAS = "Sulfuras, Hand of Ragnaros"

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def sulfras
    @name == SULFRAS
  end

end
