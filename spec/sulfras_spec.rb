require_relative '../item/sulfras'

RSpec.describe Sulfras do
  describe "#handle_aged_brie" do
    context "when sell_in is positive" do
      it "does not change quality" do
        sulfras = Sulfras.new("Sulfuras, Hand of Ragnaros", 10, 20)
        sulfras.handle_item
        expect(sulfras.quality).to eq(20)
      end
    end
    
    context "when sell_in is negative" do
      it "does not change quality" do
        sulfras = Sulfras.new("Sulfuras, Hand of Ragnaros", -1, 20)
        sulfras.handle_item
        expect(sulfras.quality).to eq(20)
      end
    end
    
    context "when quality is at 50" do
      it "does not increase quality" do
        sulfras = Sulfras.new("Sulfuras, Hand of Ragnaros", 5, 50)
        sulfras.handle_item
        expect(sulfras.quality).to eq(50)
      end
    end
  end
end
