require 'taglib'

module Tagger
  def self.tag(filename, artist, title)
    if File.exists? filename
      TagLib::MPEG::File.open(filename) do |file|
        tag = file.tag()
        tag.artist = artist
        tag.title = title
        file.save
      end
    end
  end

end