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

    context "#crawl" do
      it "should return true" do
        out = capture(:stdout) { subject.start %w(crawl) }
        expect(out.chomp).to eq("http://#{host}:#{port}/admin/,admin")
      end
    end
    context "#knock" do
      it "should return true" do
        out = capture(:stdout) { subject.start(["knock", "http://#{host}:#{port}"]) }
        expect(out.chomp).to eq("http://#{host}:#{port}/admin/,admin")
      end
    end
  end
end
