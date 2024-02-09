require './item/item.rb'
class Sulfras < Item
  SULFRAS = "Sulfuras, Hand of Ragnaros"

  def sulfras
    @name == SULFRAS
  end

  def quality
    80
  end
end
