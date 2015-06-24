require 'sinatra'

post '/updates.json' do
  content_type :json
  status 201

  request.body.read
end
