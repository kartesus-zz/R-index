require 'sinatra'
require 'uri'
require 'net/http'

require 'packages_repository'

repo = PackagesRepository.new('packages')

disable :show_exceptions

post '/updates.json' do
  content_type :json
  url = request.body.read
  packages = Net::HTTP.get(URI(url))

  begin
    repo << packages
    status 201
    url
  rescue StandardError => e
    status 502
    url
  end
end
