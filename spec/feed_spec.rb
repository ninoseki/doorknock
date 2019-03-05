# frozen_string_literal: true

RSpec.describe DoorKnock::Feed, :vcr do
  subject { DoorKnock::Feed }

  describe ".phishy_urls" do
    it "should return an array" do
      urls = subject.phishy_urls
      expect(urls).to be_an(Array)
      expect(urls.length).to be_within(50).of(100)
    end

    context "when given a size argument" do
      it "should return an array of a given size" do
        urls = subject.phishy_urls(10)
        expect(urls).to be_an(Array)
        expect(urls.length).to be_within(5).of(10)
      end
    end
  end
end
