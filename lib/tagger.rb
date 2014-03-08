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

  def self.get_tags(filename)
    TagLib::MPEG::File.open(filename) do |file|
      if file.nil?
        raise RuntimeError, "Couldn't open file #{file} while getting tags."
      else
        tag = file.id3v2_tag
        artist = tag.artist
        title = tag.title
        song = {
          remote_id: nil,
          filename: filename,
          artist: artist,
          title: title
        }
        return song
      end
    end
  end
end