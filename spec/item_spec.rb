require_relative '../item/aged_brie'
require_relative '../item/sulfras'
require_relative '../item/backstage_pass'
require_relative '../item/item'

RSpec.describe Item do
  describe "#handle_item" do
    let(:normal_item) { Item.new("normal", 10, 20) }
    let(:expired_item) { Item.new("normal", -1, 20) }

    context "when sell_in is positive for a normal item" do
      it "decreases quality by 1" do
        normal_item.handle_item
        expect(normal_item.quality).to eq(19)
      end
    end

    context "when sell_in is negative for a normal item" do
      it "decreases quality by 2" do
        expired_item.handle_item
        expect(expired_item.quality).to eq(18)
      end
    end

    context "when quality is already 0" do
      it "does not decrease quality further" do
        zero_quality_item = Item.new("normal", 10, 0)
        zero_quality_item.handle_item
        expect(zero_quality_item.quality).to eq(0)
      end
    end
  end
end
