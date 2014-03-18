# # vid2mp3-rb -- Presentation module
# Cameron Carroll, 2014
# Purpose: Prints info for user and gets responses for edit loops.

module Presenter

  def self.edit_loop(info)
    puts "Track info: "
    puts "-------------"
    satisfied = false
    until satisfied do
      info.each_with_index do |item, ii|
        field = item[0].to_s
        puts "#{field}: #{item[1]}" unless field == 'extension'
      end

      print "\nIs this satisfactory? [Y or field name to edit]: "
      response = gets.chomp
      if response =~ /y/i || response =~ /exit/i || response == ''
        satisfied = true
      else
        field = response.to_sym
        if info.include?(field)
          print "What should we change #{info[field]} to? ('cancel' to go back): "
          edit_response = gets
          unless edit_response =~ /^cancel/i
            info[field] = edit_response.chomp!
          end
        else
          puts "Invalid argument. Try 'artist', 'filename', etc...\n"
        end
      end
    end

    return info
  end

  def self.parse_manually
    puts "Couldn't get a title string for that video. Please add track info manually..."
    print "Artist: "
    artist = gets.chomp
    print "\nTitle: "
    title = gets.chomp
    print "\nFilename: "
    filename = gets.chomp

    track = {
      artist: artist,
      title: title,
      filename: filename
    }

    track = edit_loop(track)

    return track
  end

  def self.print_argument_help
    puts <<-EOS
Usage: 'vid2mp3.rb <download/add> <url>' or 'vid2mp3.rb execute'

Commands:
  (no command)        Synonym for DEFAULT_BEHAVIOR constant.
  download "url"      Immediately download and attempt to tag.
  add "url"           Attempt to tag but don't actually download yet.
  execute             Present gathered tags/videos for review/edit and actually download/convert them.
  EOS
  end

  def self.print_version
    puts "vid2mp3.rb #{VERSION}"
  end

end