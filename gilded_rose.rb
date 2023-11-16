require 'pry'
require 'pry-byebug'
class GildedRose

  def initialize(items)
    @items = items
  end


  # it has too many responsibilities
  # Single responsibility principle - broke down update_quality to smaller methods, each method has one responsibility
  def update_quality
    @items.each do |item|
      next if item.quality < 0 || item.quality > 50

      if item.sulfras
        next # Sulfuras doesn't change in quality
      elsif item.aged_brie
        item.handle_aged_brie
      elsif item.backstage_passes
        item.handle_backstage_passes
      else
        item.handle_normal_item
      end
    end
  end


end

# move items to Item
class Item
  attr_accessor :name, :sell_in, :quality
  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  SULFRAS = "Sulfuras, Hand of Ragnaros"

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  # Encaalpsulation - each method specific to updating the quality of different types of items
  def handle_aged_brie
    increase_quality
    decrease_sell_in
    if @sell_in < 0 && @quality < 50
      increase_quality
    end
  end

  def handle_backstage_passes
    increase_quality
    increase_quality if @sell_in < 11
    increase_quality if @sell_in < 6
    decrease_sell_in
    @quality = 0 if @sell_in < 0
  end

  def handle_normal_item
    decrease_quality
    decrease_sell_in
    if @sell_in < 0
      !sulfras_and_backstage ? decrease_quality : @quality = 0
    end
  end

  def aged_brie
    @name == AGED_BRIE
  end
  
  def backstage_passes
    @name == BACKSTAGE_PASSES
  end

  def sulfras
    @name == SULFRAS
  end

  def sulfras_and_backstage
    sulfras || backstage_passes
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
