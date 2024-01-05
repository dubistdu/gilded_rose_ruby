require_relative '../item/backstage_pass'  # Adjust path as necessary

RSpec.describe BackstagePass do
  describe "#handle_backstage_passes" do
    context "when sell_in is more than 10 days" do
      it "increases quality by 1" do
        pass = BackstagePass.new("Backstage passes to a ImagineDragons concert", 11, 20)
        pass.handle_item
        expect(pass.quality).to eq(21)
      end
    end

    context "when sell_in is 10 days or less" do
      it "increases quality by 2" do
        pass = BackstagePass.new("Backstage passes to a ImagineDragons concert", 10, 20)
        pass.handle_item
        expect(pass.quality).to eq(22)
      end
    end

    context "when sell_in is 5 days or less" do
      it "increases quality by 3" do
        pass = BackstagePass.new("Backstage passes to a ImagineDragons concert", 5, 20)
        pass.handle_item
        expect(pass.quality).to eq(23)
      end
    end

    context "after the concert (sell_in less than 0)" do
      it "drops quality to 0" do
        pass = BackstagePass.new("Backstage passes to a ImagineDragons concert", 0, 20)
        pass.handle_item
        expect(pass.quality).to eq(0)
      end
    end
  end
end
