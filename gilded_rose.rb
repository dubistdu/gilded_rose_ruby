require 'pry'
require 'pry-byebug'
Dir["./item/*.rb"].each {|file| require file }
class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.handle_item
    end
  end
end

