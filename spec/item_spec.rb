require_relative '../item/aged_brie'
require_relative '../item/sulfras'
require_relative '../item/backstage_pass'
require_relative '../item/item'


RSpec.describe Item do
  describe "#handle_normal_item" do
    let(:normal_item) { Item.new("normal", 10, 20) }
    let(:expired_item) { Item.new("normal", -1, 20) }

    context "when sell_in is positive for a normal item" do
      it "decreases quality by 1" do
        normal_item.handle_normal_item
        expect(normal_item.quality).to eq(19)
      end
    end

    context "when sell_in is negative for a normal item" do
      it "decreases quality by 2" do
        expired_item.handle_normal_item
        expect(expired_item.quality).to eq(18)
      end
    end

    context "when quality is already 0" do
      it "does not decrease quality further" do
        zero_quality_item = Item.new("normal", 10, 0)
        zero_quality_item.handle_normal_item
        expect(zero_quality_item.quality).to eq(0)
      end
    end

    context "when item is Sulfras" do
      it "does not change quality or sell_in" do
        original_quality = sulfras_item.quality
        original_sell_in = sulfras_item.sell_in
        sulfras_item.handle_normal_item
        expect(sulfras_item.quality).to eq(original_quality)
        expect(sulfras_item.sell_in).to eq(original_sell_in)
      end
    end

    context "when item is a Backstage Pass" do
      it "does not change quality or sell_in" do
        original_quality = backstage_item.quality
        original_sell_in = backstage_item.sell_in
        backstage_item.handle_normal_item
        expect(backstage_item.quality).to eq(original_quality)
        expect(backstage_item.sell_in).to eq(original_sell_in)
      end
    end
  end
end
