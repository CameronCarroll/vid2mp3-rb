# # vid2mp3-rb -- Behavior handler
# Cameron Carroll, 2014
# Purpose: Accepts opts hash with digested arguments/commands, implements simple behaviors and delegates the rest.

require_relative 'downloader'
require_relative 'titlestringparser'

module Handler
  def self.handle_behavior(opts)
    if opts[:help]
      print_argument_help
    elsif opts[:version]
      print_version
    elsif opts[:download]
      title_string = Downloader.get_title_string(opts[:download])
      info = TitlestringParser.parse(title_string)
      puts info
    elsif opts[:add]
      title_string = Downloader.get_title_string(opts[:add])
      info = TitlestringParser.parse(title_string)
    elsif opts[:execute]
    else
      raise RuntimeError, "Didn't get a behavior back from argument parser."
    end
  end

  def print_argument_help
    puts <<-EOS
Usage: 'vid2mp3.rb <download/add> <url>' or 'vid2mp3.rb execute'

Commands:
  (no command)        Synonym for DEFAULT_BEHAVIOR constant.
  download "url"      Immediately download and attempt to tag.
  add "url"           Attempt to tag but don't actually download yet.
  execute             Present gathered tags/videos for review/edit and actually download/convert them.
  EOS
  end

  def print_version
    puts "vid2mp3.rb #{VERSION}"
  end
end