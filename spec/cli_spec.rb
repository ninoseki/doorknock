# frozen_string_literal: true

RSpec.describe DoorKnock::Website do
  include_context "http_server"

  subject { DoorKnock::CLI }

  describe "#start" do
    let(:input) { "http://#{host}:#{port}/" }
    before do
      allow(DoorKnock::Feed).to receive(:phishy_urls).and_return([input])
      allow(Parallel).to receive(:each).with([input]).and_yield(input)
    end

    it "should return true" do
      out = capture(:stdout) { subject.start %w(knock) }
      expect(out.chomp).to eq("http://#{host}:#{port}/admin/,admin")
    end
  end
end
