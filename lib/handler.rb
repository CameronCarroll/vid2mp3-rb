# # vid2mp3-rb -- Behavior handler
# Cameron Carroll, 2014
# Purpose: Accepts opts hash with digested arguments/commands, implements simple behaviors and delegates the rest.

require_relative 'downloader'
require_relative 'titlestringparser'
require_relative 'presenter'
require_relative 'converter'
require_relative 'tagger'
require_relative 'library'

module Handler
  def self.handle_behavior(opts)
    if opts[:help]
      Presenter.print_argument_help
    elsif opts[:version]
      Presenter.print_version
    elsif opts[:download]
      title_string = Downloader.get_title_string(opts[:download])

      if title_string.count('-') > 0
        info = TitlestringParser.parse(title_string)
        info = Presenter.edit_loop(info)
      else
        info = Presenter.parse_manually
      end
      
      song = {
        remote_id: opts[:download],
        filename: info[:filename],
        artist: info[:artist],
        title: info[:full_title] ? info[:full_title] : info[:title] 
      }
      raise RuntimeError, "Already found that song in library or queue." if Library.already_have? song
      puts "\nDownloading video file, then handing off to ffmpeg for conversion. Just a few moments...\n"
      saved_path = Downloader.download(song[:remote_id], song[:filename])
      local_path = Converter.convert(saved_path)
      File.delete saved_path if File.exists?(local_path)
      Tagger.tag(local_path, song[:artist], song[:title])
      Library.add(song)
    elsif opts[:add]
      title_string = Downloader.get_title_string(opts[:add])
      info = TitlestringParser.parse(title_string)
      # add this info to internal queue
    elsif opts[:execute]
      # open up internal queue
      # for each item, present to user and allow to edit
      # for each item, download and convert and rename and tag
    elsif opts[:scan]
      dir = opts[:scan]
      puts "Scanning #{dir} for files to add to library."
      Library.scan(dir)
    else
      raise RuntimeError, "Didn't get a behavior back from argument parser."
    end
  end
end