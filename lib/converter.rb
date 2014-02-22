module Converter
  def self.convert(path)
    mp3_path = File.dirname(path) + '/' + File.basename(path, ".*") + '.mp3'

    if path =~ /.mp4\z/i
      system("ffmpeg -i #{path} -b:a 320K -vn #{mp3_path}")
    elsif path =~ /.webm\z/i
      system("ffmpeg -i #{path} -b:a 320K -acodec libmp3lame -aq 4 #{mp3_path}")
    end

    return mp3_path
  end
end