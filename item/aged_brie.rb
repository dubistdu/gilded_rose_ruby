require_relative 'item'

class AgedBrie < Item
  AGED_BRIE = "Aged Brie"

  def initialize(name, sell_in, quality)
    super(name, sell_in, quality)
  end

  def handle_item
    increase_quality
    decrease_sell_in

    if @sell_in < 0
      increase_quality
    end

    @quality = @quality_obj.value
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
