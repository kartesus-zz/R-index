require 'rack/test'
require 'sinatra'

require 'server_api'

RSpec.describe "Server API" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "POST /updates.json" do
    it "accepts new update request" do
      post '/updates.json', 'http://localhost:1234/PACKAGES'
      expect(last_response).to be_created
      expect(last_response.body).to eq('http://localhost:1234/PACKAGES')
    end
  end
end
