# # vid2mp3-rb -- Behavior handler
# Cameron Carroll, 2014
# Purpose: Accepts opts hash with digested arguments/commands, implements simple behaviors and delegates the rest.

require_relative 'downloader'
require_relative 'titlestringparser'
require_relative 'presenter'

module Handler
  def self.handle_behavior(opts)
    if opts[:help]
      Presenter.print_argument_help
    elsif opts[:version]
      Presenter.print_version
    elsif opts[:download]
      title_string = Downloader.get_title_string(opts[:download])
      info = TitlestringParser.parse(title_string)
      puts Presenter.edit_loop(info)
      # present info to user, allow them to edit
      # actually download video
      # convert video
      # rename
      # tag
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