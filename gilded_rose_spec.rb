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

    # Refactor thoughts...divide context by item quality increase/ decrease


   # - "Aged Brie" actually increases in Quality the older it gets
    context "if the item is 'Aged Brie' " do
      it "increases quality when sell by date has passed" do
        items = [Item.new("Aged Brie", 9, 10)]
        gilded_rose = GildedRose.new(items)
        2.times{ gilded_rose.update_quality }
        expect(items[0].quality).to eq 12
      end
    end

    # "Sulfuras" is a legendary item and as such its Quality is 80 and it never alters.
    context "if the item is 'Sulfuras'" do
      it "does not decrease quality when sell by date has passed" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 9, 10)]
        gilded_rose = GildedRose.new(items)
        12.times{ gilded_rose.update_quality }
        expect(items[0].quality).to eq 10
      end
    end

    # - "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
    # Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
    # Quality drops to 0 after the concert

    context "if the item is 'Backstage passes'" do
      it "increases quality by 2 when there are 10 days or less to concert date" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 8, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 12
      end

      it "increases qaulity by 3 when there are 5 days or less to concert date" do
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

    # - The Quality of an item is never more than 50-----

    context "the quality of item is never negative" do
      it "remains non negative in quality when sell_in data is past" do
        items = [Item.new("Wine", 2, 2)]
        gilded_rose = GildedRose.new(items)
        3.times{ gilded_rose.update_quality() }
        expect(items[0].quality).to be >= 0
        expect(items[0].sell_in).to eq -1
      end
    end

    context "When sell by date has passed" do
      it "degrades quality twice as fast" do
        items = [Item.new("Potato", 1, 50)]
        gilded_rose = GildedRose.new(items)
        3.times{ gilded_rose.update_quality }
        expect(items[0].quality).to eq 45
      end
    
    end

    it "increatese item quality" do
      items = [Item.new("Potato", 1, 10)]
      gilded_rose = GildedRose.new(items)
      item = items[0]
      expect(gilded_rose.increase_item_quality(item)).to eq(11)
    end

    it "decreases item quality" do
      items = [Item.new("Potato", 1, 10)]
      gilded_rose = GildedRose.new(items)
      item = items[0]
      expect(gilded_rose.decreases_item_quality(item)).to eq(9)
    end

    it "decreases sell_in" do
      items = [Item.new("Potato", 5, 10)]
      gilded_rose = GildedRose.new(items)
      item = items[0]
      expect(gilded_rose.decreases_sell_in(item)).to eq(4)
    end


    # conjured need to be implemented
    # context "if the item is 'Conjured'" do
    #   it "degrades in quality twice as fast as normal items" do
    #     items = [Item.new("Conjured", 10, 20)]
    #     gilded_rose = GildedRose.new(items)
    #     gilded_rose.update_quality()
    #     expect(items[0].quality).to eq 18
    #   end
    
    #   it "degrades in quality twice as fast as normal items even after sell_in" do
    #     items = [Item.new("Conjured", 0, 20)]
    #     gilded_rose = GildedRose.new(items)
    #     gilded_rose.update_quality()
    #     expect(items[0].quality).to eq 16
    #   end
    # end

  end

end

#tests/edge cases not in readme (something to consider)

# Just for clarification, an item can never have its Quality increase above 50, however "Sulfuras" is a
# legendary item and as such its Quality is 80 and it never alters.
