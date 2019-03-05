# frozen_string_literal: true

RSpec.describe DoorKnock::Website do
  include_context "http_server"

  subject { DoorKnock::CLI }

  describe "#start" do
    before do
      allow(DoorKnock::Feed).to receive(:phishy_urls).and_return(["http://#{host}:#{port}/"])
    end

    it "should return true" do
      out = capture(:stdout) { subject.start %w(knock) }
      expect(out.chomp).to eq("http://#{host}:#{port}/admin/,admin")
    end
  end
end
