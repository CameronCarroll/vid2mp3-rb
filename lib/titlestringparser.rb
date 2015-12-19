# # vid2mp3-rb -- Youtube video title-string parser
# Cameron Carroll, 2014
# Purpose: Accepts a youtube video title string and attempts to extract the
#          artist, title and any notes from it.
# Koven - Make It There (feat. Folly Rae) (The Prototypes Remix).mp4

module TitlestringParser
  def self.parse(title_string)
    artist, remainder = title_string.split(' - ')
    artist.strip!
    if remainder.include?(")") # then we know we have notes
      split = remainder.split("(")
      title = split.shift.strip
      last_note, extension = split.pop.split(")")
      notes = []
      split.each do |note|
        notes << note
      end
      notes << last_note
    else
      title, extension = remainder.split('.')
      extension = "." + extension
    end
    info = {:artist => artist, :title => title, :notes => notes, :extension => extension}

    return info
  end

  def self.get_extension(title_string)
    extension = '.' + title_string.split('.')[-1]
  end
end
