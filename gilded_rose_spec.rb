require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'date'

describe GildedRose do

  describe "#update_quality" do
    context "item" do
      it "does not change the name" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].name).to eq "foo"
      end
    end

   # - "Aged Brie" actually increases in Quality the older it gets
    context "if the item is 'Aged Brie' " do
      it "does not decrease quality when sell by date has passed" do
        items = [Item.new("Aged Brie", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 11
      end
    end

    # - "Sulfuras", being a legendary item, never has to be sold or decreases in Quality 
    #(not true, test doesn't prove it. Test decreases quality)
    context "if the item is 'Sulfuras'" do
      it "does not decrease quality when sell by date has passed" do
        items = [Item.new("Sulfuras", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 9
      end
    end

    # - "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
    # Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
    # Quality drops to 0 after the concert

    # Code doesn't seem to reflect it
    context "if the item is 'Backstage passes'" do
      it "increases quality as it gets closer to concert date" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 13
      end

      it "drops quality to 0 after it has past concert date" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end


    # - The Quality of an item is never negative
    # - Once the sell by date has passed, Quality degrades twice as fast
    # - The Quality of an item is never more than 50-----

  

  end

end
