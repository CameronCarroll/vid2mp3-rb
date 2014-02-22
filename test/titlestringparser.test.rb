# vid2mp3-rb -- titlestringparser.rb test file
# Cameron Carroll -- 2014
# Purpose: Tests the parser's ability to break down various video titles from youtube containing audio track data.


require "minitest/spec"
require "minitest/autorun"
require "minitest/unit"

require_relative "../lib/titlestringparser"

describe TitlestringParser do
  before do

  end
  describe "passing artist - title.extension" do
    it "should return artist and title and filetype" do
      title_string = "Koven - Make It There.mp4"
      correct_response = {artist: "Koven", title: "Make It There", extension: ".mp4", filename: "koven_make-it-there.mp3"}
      TitlestringParser.parse(title_string).must_equal correct_response
    end
  end

  describe "passing artist - title (note).extenion" do
    it "should return artist, title and the note and the filetype" do
      title_string = "Koven - Make It There (feat. Folly Rae).mp4"
      correct_response = {artist: "Koven", title: "Make It There", notes: ["feat. Folly Rae"], extension: ".mp4", filename: "koven_make-it-there_feat-folly-rae.mp3"}
      TitlestringParser.parse(title_string).must_equal correct_response
    end
  end

  describe "passing artist - title (note 1) ... (note n).extension" do
    it "should return artist, title, and the notes and also filetype" do
      title_string = "Koven - Make It There (feat. Folly Rae) (The Prototypes Remix).mp4"
      correct_response = {artist: "Koven", title: "Make It There", notes: ["feat. Folly Rae", "The Prototypes Remix"], extension: ".mp4", filename: "koven_make-it-there_feat-folly-rae_the-prototypes-remix.mp3"}
      TitlestringParser.parse(title_string).must_equal correct_response
    end
  end
end