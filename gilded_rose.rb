require 'pry'
require 'pry-byebug'
Dir["./item/*.rb"].each {|file| require file }
class GildedRose

  def initialize(items)
    @items = items
  end

  # it has too many responsibilities
  # Single responsibility principle - broke down update_quality to smaller methods, each method has one responsibility
  def update_quality
    @items.each do |item|
      next if item.quality < 0 || item.quality > 50

      if item.name == Sulfras::SULFRAS
        next # Sulfuras doesn't change in quality
      elsif item.name == AgedBrie::AGED_BRIE
        item.handle_aged_brie
      elsif item.name == BackstagePass::BACKSTAGE_PASSES
        item.handle_backstage_passes
      else
        item.handle_normal_item
      end
    end
  end
end

