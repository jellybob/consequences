require "sinatra"
require "json"
require "pp"

PARTS = %w(males females meetings male_phrases female_phrases outcomes).map { |part|
  [part.to_sym, File.read("#{part}.txt").lines]
}.to_h

def phrase(key)
  PARTS[key].sample
end

post "/" do
  person_one = phrase(:males)
  person_two = phrase(:females)
  meeting = phrase(:meetings)
  phrase_one = phrase(:male_phrases)
  phrase_two = phrase(:female_phrases)
  outcome = phrase(:outcomes)

  story = %Q{
    <speak>
      One day <w role="amazon:NN">#{person_one}</w> and <w role="amazon:NN">#{person_two}</w> met #{meeting}.<break strength="x-strong" />He said \"#{phrase_one}\". She responded \"#{phrase_two}\", and then #{outcome}.
    </speak>
  }

  {
    "version": "1.0",
    "sessionAttributes": {},
    "response": {
      "outputSpeech": {
        "type": "SSML",
        "ssml": story,
      },
      "card": {
        "type": "Simple",
        "title": "Your Story",
        "content": story,
      },
      "shouldEndSession": true
    }
  }.to_json
end
