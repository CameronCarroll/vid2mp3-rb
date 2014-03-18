# # vid2mp3-rb -- Youtube video title-string parser
# Cameron Carroll, 2014
# Purpose: Accepts a youtube video title string and attempts to extract the
#          artist, title and any notes from it.
# Koven - Make It There (feat. Folly Rae) (The Prototypes Remix).mp4

module TitlestringParser
  def self.parse(title_string)
    artist, remainder = title_string.split(' - ')
    if remainder.include?(")") # then we know we have notes
      split = remainder.split("(")
      title = split.shift
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

    artist.strip!
    title.strip!
    clean_notes = []

    filename = "#{artist.gsub(' ', '-').downcase}_#{title.gsub(' ', '-').downcase}"
    full_title = "#{title}"

    if notes
      notes.each do |note|
        clean_note = note.strip.gsub("(", "").gsub(")", "")
        clean_notes << clean_note
        filename << "_" + clean_note.gsub('.', '').downcase.gsub(' ', '-')
        full_title << " (#{clean_note})"
      end
    end

    filename << extension

    if notes
      return {artist: artist, title: title, extension: extension, filename: filename, notes: clean_notes, full_title: full_title}
    else
      return {artist: artist, title: title, extension: extension, filename: filename}
    end
  end
end