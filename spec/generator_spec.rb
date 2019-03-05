# frozen_string_literal: true

RSpec.describe DoorKnock::Generator do
  subject {
    DoorKnock::Generator.new(
      ["http://example.com", "http://example.com/foo/bar"]
    )
  }

  describe "#paths" do
    it "should return an array" do
      expect(subject.paths).to be_an(Array)
    end
  end

  describe "#admin_panel_urls" do
    it "should return an array" do
      expect(subject.admin_panel_urls).to be_an(Array)
    end
  end
end
