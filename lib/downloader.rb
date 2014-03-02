# # vid2mp3-rb -- Download handler
# Cameron Carroll, 2014
# Purpose: Interfaces with viddl-rb to download videos or video information from youtube.

require 'viddl-rb'
require 'open-uri'

module Downloader
  def self.get_title_string(id)
    url = "https://www.youtube.com/watch?v=" + id
    result = ViddlRb.get_names(url).first
    puts result
    return result
  end

  def self.download(id, filename)
    url = "https://www.youtube.com/watch?v=" + id
    dl_url = ViddlRb.get_urls(url).first
    File.open(SAVE_PATH + filename, "wb") do |saved_file|
      open(dl_url, "rb") do |read_file|
        saved_file.write(read_file.read)
      end
    end

    return SAVE_PATH + filename
  end
end