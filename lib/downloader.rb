# # vid2mp3-rb -- Download handler
# Cameron Carroll, 2014
# Purpose: Interfaces with viddl-rb to download videos or video information from youtube.

require 'viddl-rb'

module Downloader
  def self.get_title_string(id)
    url = "https://www.youtube.com/watch?v=" + id
    return ViddlRb.get_names(url).first
  end
end