require 'json'
require 'fileutils'
FileUtils.rm_rf File.expand_path('../data', File.dirname(__FILE__))

require 'rack/test'
require 'sinatra'

require 'server_api'

RSpec.describe "Server API" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "POST /updates" do
    it "accepts new update request" do
      post '/updates', 'http://localhost:1234/PACKAGES'
      expect(last_response).to be_created
      expect(last_response.body).to eq('http://localhost:1234/PACKAGES')
    end

  end

  describe "GET /packages.json" do
    it "returns a json representation of packages" do
      post '/updates', 'http://localhost:1234/PACKAGES'
      get '/packages.json'
      packages = JSON.parse(last_response.body)
      expect(last_response).to be_ok
      expect(packages.first).to eq({"name" => "A3", "latest_version" => "0.9.2"})
    end
  end
end
