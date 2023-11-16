require 'pry'
require 'pry-byebug'
class GildedRose
  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  SULFRAS = "Sulfuras, Hand of Ragnaros"

  def initialize(items)
    @items = items
  end


  # it has too many responsibilities
  # Single responsibility principle - broke down update_quality to smaller methods, each method has one responsibility
  def update_quality
    @items.each do |item|
      next if item.quality < 0 || item.quality > 50

      if sulfras(item)
        next # Sulfuras doesn't change in quality
      elsif aged_brie(item)
        handle_aged_brie(item)
      elsif backstage_passes(item)
        handle_backstage_passes(item)
      else
        handle_normal_item(item)
      end
    end
  end

  private
  # Encaalpsulation - each method specific to updating the quality of different types of items
  def handle_aged_brie(item)
    increase_quality(item)
    decrease_sell_in(item)
    if item.sell_in < 0 && item.quality < 50
      increase_quality(item)
    end
  end

  # 10 days or less until the concert, the quality of the "Backstage passes" increases by an additional point (total of 2 points on that day).
  def handle_backstage_passes(item)
    increase_quality(item)
    increase_quality(item) if item.sell_in < 11
    increase_quality(item) if item.sell_in < 6
    decrease_sell_in(item)
    item.quality = 0 if item.sell_in < 0
  end

  def handle_normal_item(item)
    decrease_quality(item)
    decrease_sell_in(item)
    if item.sell_in < 0
      !sulfras_and_backstage(item) ? decrease_quality(item) : item.quality = 0
    end
  end

# Refactoring for DRY Principle:
# Instead of repeating the logic for increasing and decreasing item quality
# within each item's specific logic, these methods are extractedinto separate methods.
# This approach:
# - Enhances code readability by having a clear, single-purpose function for each action.
# - DRY principle
# - Simplifies future modifications, as changes to quality adjustment logic
#   only need to be made in one place.
  def increase_quality(item)
    return if item.quality >= 50
    item.quality += 1
  end

  def decrease_quality(item)
    item.quality -= 1 if item.quality > 0
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
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

  def sulfras_and_backstage(item)
    sulfras(item) || backstage_passes(item)
  end
end

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
end
