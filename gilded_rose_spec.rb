require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'date'

describe GildedRose do
  describe "#update_quality" do
    context "when the item is regular" do
      it "degrades quality twice as fast after the sell by date" do
        items = [Item.new("Potato", 1, 50)]
        gilded_rose = GildedRose.new(items)
        3.times { gilded_rose.update_quality }
        expect(items[0].quality).to eq 45
      end
    end

    context "when the item is 'Aged Brie'" do
      it "increases quality as it gets older" do
        items = [Item.new("Aged Brie", 2, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 1
        expect(items[0].sell_in).to eq 1
      end

      it "increases quality twice as fast after the sell by date" do
        items = [Item.new("Aged Brie", 0, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 2
      end
    end

    context "when the item is 'Sulfuras'" do
      it "never decreases in quality or sell_in" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 80
        expect(items[0].sell_in).to eq 0
      end
    end

    context "when the item is 'Backstage passes'" do
      it "increases quality by 2 when there are 10 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 12
      end

      it "increases quality by 3 when there are 5 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 13
      end

      it "drops quality to 0 after the concert" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end
    end

    context "when the item is of any type" do
      it "does not change the name" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].name).to eq "foo"
      end

      it "the quality of an item is never negative" do
        items = [Item.new("Wine", 2, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to be >= 0
      end

      it "the quality of an item never exceeds 50 (except 'Sulfuras')" do
        items = [Item.new("Aged Brie", 2, 49)]
        GildedRose.new(items).update_quality
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 50
      end
    end
    
    # conjured need to be implemented
  end
end
