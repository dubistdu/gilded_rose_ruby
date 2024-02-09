require_relative 'quality'
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality_obj = Quality.new(quality)
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def handle_item
    # return @quality if @quality < 0 || @quality > 50
    @quality_obj.decrease_value
    decrease_sell_in
    if @sell_in < 0
      @quality_obj.decrease_value
    end
    quality
  end

  def decrease_sell_in
    @sell_in -= 1
  end

  def quality
    @quality_obj.value
  end
end

