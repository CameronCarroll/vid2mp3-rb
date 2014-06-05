# # vid2mp3-rb -- Presentation module
# Cameron Carroll, 2014
# Purpose: Prints info for user and gets responses for edit loops.

module Presenter

  # Interactive loop which allows user to edit the video tag data extracted from title string.
  # We need to prepare both the user-readable artist, title and note data for mp3 tagging,
  # and also the filesystem-safe filename with everything special stripped away.
  def self.edit_loop(info)
    puts "Track info: "
    puts "-------------"
    satisfied = false
    new_info = {}
    until satisfied do
      # Filenames can't have special characters in them. Apostrophes, periods and ampersands occur all the time.
      # We'll just remove apostrophes/periods and change ampersands to 'n'.
      # We also need to change spaces to dashes.
      
      info[:filename] = "#{cleanup info[:artist]}_#{cleanup info[:title]}"
      info[:full_title] = "#{info[:title]}"

      info[:chosen_filename] = "n/a"

      notes = info[:notes]
      naked_notes = []
      if notes
        notes.each do |note|
          note = note.strip.gsub("(", "").gsub(")", "")
          naked_notes << note
          info[:filename] << "_" + cleanup(note)
          info[:full_title] << " (#{note})"
        end
      end

      info[:filename] << info[:extension]
      editable_info = info.reject {|k| k == :notes || k == :extension || k == :filename}
      editable_info.each_with_index do |item, ii|
        field = item[0].to_s
        puts "#{field}: #{item[1]}"
      end
      puts ""
      puts "Generated Filename: #{info[:filename]}"
      puts "Generated Full Title: #{info[:full_title]}"
      info[:filename] = info[:chosen_filename] unless info[:chosen_filename] == 'n/a'
      new_info = {:artist => info[:artist], :title => info[:title], :full_title => info[:full_title], :filename => info[:filename], :chosen_filename => ''}

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
          puts "\n\n"
        else
          puts "Invalid argument. Try 'artist', 'title', or 'filename'.\n"
          puts "\n\n"
        end
      end
    end

    return new_info
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

  # Helper function to prepare data for filename use
  def self.cleanup(piece)
    piece.gsub('&', 'n').gsub('\'', '').gsub(' ', '-').gsub('.', '').downcase
  end

end