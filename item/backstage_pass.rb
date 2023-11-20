require './item/item.rb'
class BackstagePass < Item
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  # def backstage_passes
  #   @name == BACKSTAGE_PASSES
  # end

  def handle_backstage_passes
    increase_quality
    increase_quality if @sell_in < 11
    increase_quality if @sell_in < 6
    decrease_sell_in
    @quality = 0 if @sell_in < 0
  end

end
