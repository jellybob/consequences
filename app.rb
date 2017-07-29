require "sinatra"
require "json"
require "pp"

MALES = File.read("male.txt").lines
FEMALES = File.read("female.txt").lines
MEETINGS = File.read("meetings.txt").lines
MALE_PHRASES = File.read("male_phrase.txt").lines
FEMALE_PHRASES = File.read("female_phrase.txt").lines
OUTCOMES = File.read("outcomes.txt").lines

post "/" do
  person_one = MALES.sample
  person_two = FEMALES.sample
  meeting = MEETINGS.sample
  phrase_one = MALE_PHRASES.sample
  phrase_two = FEMALE_PHRASES.sample
  outcome = OUTCOMES.sample

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

def random_person(exclude = nil)
  sample_with_exclusion(["Jim", "Bob", "Jo"], exclude)
end

def random_meeting
  ["Foo"].sample
end

def random_phrase(exclude = nil)
  sample_with_exclusion(["Foo", "bar"], exclude)
end

def random_outcome
  ["Bar"].sample
end

def sample_with_exclusion(haystack, exclude = nil)
  haystack.reject { |p| p == exclude }.sample
end
