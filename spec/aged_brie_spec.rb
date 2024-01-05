require_relative '../item/aged_brie'

RSpec.describe AgedBrie do
  describe "#handle_item" do
    context "when sell_in is positive" do
      it "increases quality by 1" do
        brie = AgedBrie.new("Aged Brie", 10, 20)
        brie.handle_item
        expect(brie.quality).to eq(21)
      end
    end

    context "when sell_in is negative" do
      it "increases quality by 2" do
        brie = AgedBrie.new("Aged Brie", -1, 20)
        brie.handle_item
        expect(brie.quality).to eq(22)
      end
    end

    context "when quality is at 50" do
      it "does not increase quality" do
        brie = AgedBrie.new("Aged Brie", 5, 50)
        brie.handle_item
        expect(brie.quality).to eq(50)
      end
    end
  end
end
