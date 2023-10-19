require 'pry'
require 'pry-byebug'
class GildedRose
  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  SULFRAS = "Sulfuras, Hand of Ragnaros"

  def initialize(items)
    @items = items
  end

  # break down the method
  def update_quality
    @items.each do |item|
      if !brie_and_backstage(item)
        if item.quality > 0 && !sulfras(item)
          decreases_item_quality(item)
        end
      else
        return if item.quality >= 50
        increase_item_quality(item)
        if backstage_passes(item) && item.sell_in < 11
            increase_item_quality(item)
        end
        if backstage_passes(item) && item.sell_in < 6
            increase_item_quality(item)
        end
      end

      if !sulfras
        decreases_sell_in(item)
      end

      if item.sell_in < 0 && aged_brie(item) && item.quality < 50
        increase_item_quality(item)
      end

      if item.sell_in < 0 && !aged_brie(item)
        if !sulfras_and_backstage(item) && item.quality > 0
          decreases_item_quality(item)
        else
          item.quality = 0
        end
      end
    end
  end

  def increase_item_quality(item)
    item.quality += 1
  end

  def decreases_item_quality(item)
    item.quality -= 1
  end

  def decreases_sell_in(item)
    item.sell_in -= 1
  end

  def brie_and_backstage(item)
    aged_brie(item) || backstage_passes(item)
  end

  def sulfras_and_backstage(item)
    sulfras(item) || backstage_passes(item)
  end

  def aged_brie(item)
    item.name == AGED_BRIE
  end
  
  def backstage_passes(item)
    item.name == BACKSTAGE_PASSES
  end

  def sulfras(item)
    item.name == SULFRAS
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
