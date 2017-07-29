require "sinatra"
require "json"

post "/" do
  {
    "speech": "Hi there",
    "displayText": "Hi there",
  }.to_json
end
