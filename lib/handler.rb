# # vid2mp3-rb -- Behavior handler
# Cameron Carroll, 2014
# Purpose: Accepts opts hash with digested arguments/commands, implements simple behaviors and delegates the rest.

require_relative 'downloader'
require_relative 'titlestringparser'
require_relative 'presenter'
require_relative 'converter'
require_relative 'tagger'

module Handler
  def self.handle_behavior(opts)
    if opts[:help]
      Presenter.print_argument_help
    elsif opts[:version]
      Presenter.print_version
    elsif opts[:download]
      title_string = Downloader.get_title_string(opts[:download])
      info = TitlestringParser.parse(title_string)
      info = Presenter.edit_loop(info)
      puts "\nDownloading video file, then handing off to ffmpeg for conversion. Just a few moments...\n"
      saved_path = Downloader.download(opts[:download], info[:filename])
      mp3_path = Converter.convert(saved_path)
      File.delete saved_path if File.exists?(mp3_path)
      Tagger.tag(mp3_path, info[:artist], info[:full_title] ? info[:full_title] : info[:title])
    elsif opts[:add]
      title_string = Downloader.get_title_string(opts[:add])
      info = TitlestringParser.parse(title_string)
      # add this info to internal queue
    elsif opts[:execute]
      # open up internal queue
      # for each item, present to user and allow to edit
      # for each item, download and convert and rename and tag
    else
      raise RuntimeError, "Didn't get a behavior back from argument parser."
    end
  end
end