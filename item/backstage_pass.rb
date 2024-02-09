require './item/item.rb'

class BackstagePass < Item
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"

  def initialize(name, sell_in, quality)
    super(name, sell_in, quality)
  end

  def handle_item
    increase_quality

    increase_quality if @sell_in < 11
    increase_quality if @sell_in < 6

    decrease_sell_in

    if @sell_in < 0
      @quality_obj = Quality.new(0) # Reset quality to 0 after the concert
    end
  end

  private

  def increase_quality
    if @quality_obj.value < 50
      @quality_obj.increase_value
    end
  end

  def decrease_sell_in
    @sell_in -= 1
  end
end
