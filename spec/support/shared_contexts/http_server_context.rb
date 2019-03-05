# frozen_string_literal: true

require "glint"
require "webrick"

HOST = "127.0.0.1"

def server
  server = Glint::Server.new do |port|
    http = WEBrick::HTTPServer.new(
      BindAddress: HOST,
      Port: port,
      Logger: WEBrick::Log.new(File.open(File::NULL, "w")),
      AccessLog: []
    )

    http.mount_proc("/admin") do |_, res|
      body = File.read(File.expand_path("./index.html", __dir__))

      res.status = 200
      res.content_length = body.size
      res.content_type = 'text/plain'
      res.body = body
    end

    trap(:INT) { http.shutdown }
    trap(:TERM) { http.shutdown }
    http.start
  end

  Glint::Server.info[:http_server] = {
    host: HOST,
    port: server.port
  }
  server
end

RSpec.shared_context "http_server" do
  before(:all) {
    @server = server
    @server.start
  }
  after(:all) { @server.stop }

  let(:host) { HOST }
  let(:port) { @server.port }
end
