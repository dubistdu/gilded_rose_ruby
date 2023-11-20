# move items to Item
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def handle_normal_item
    decrease_quality
    decrease_sell_in
    if @sell_in < 0
      !sulfras_and_backstage ? decrease_quality : @quality = 0
    end
  end

  def sulfras_and_backstage
    name == Sulfras::SULFRAS || name == BackstagePass::BACKSTAGE_PASSES
  end

  def increase_quality
    return if @quality >= 50
    @quality += 1
  end

  def decrease_quality
    @quality -= 1 if @quality > 0
  end

  def decrease_sell_in
    @sell_in -= 1
  end
end
