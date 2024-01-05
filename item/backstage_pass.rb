require './item/item.rb'
class BackstagePass < Item
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"

  def handle_item
    increase_quality
    increase_quality if @sell_in < 11
    increase_quality if @sell_in < 6
    decrease_sell_in
    @quality = 0 if @sell_in < 0
    
    @quality
  end

end
