# frozen_string_literal: true

RSpec.describe DoorKnock::Website do
  include_context "http_server"

  subject { DoorKnock::Website.new("http://#{host}:#{port}/admin") }

  describe "#ok?" do
    it "should return true" do
      expect(subject.ok?).to eq(true)
    end
  end

  describe "#panel?" do
    it "should return true" do
      expect(subject.panel?).to eq(true)
    end
  end

  describe "#title" do
    it "should return a title of a website" do
      expect(subject.title).to eq("admin")
    end
  end
end
