require 'sinatra'
require 'uri'
require 'net/http'
require 'json'

require 'packages_repository'

repo = PackagesRepository.new('packages')

disable :show_exceptions

post '/updates' do
  content_type :text

  url = request.body.read
  packages = Net::HTTP.get(URI(url))

  begin
    manifest = Manifest.new(packages)
    repo << manifest.take(50)
    status 201
    url
  rescue StandardError => e
    status 502
    url
  end
end

get '/packages.json' do
  content_type :json
  repo.all.to_json
end
