# # vid2mp3-rb -- Music library module
# Cameron Carroll, 2014
# Purpose: Implements a very rudimentary music library, recording title, artist, url, local path, filename.
#          Also manages the download queue. This is intended to avoid duplicated downloads.

require 'yaml'
require 'fileutils'
require_relative 'tagger'
require 'pry'

module Library
  @@library = nil
  @@queue = nil

  def self.add(song)
    setup
    @@library << song
    save_hash_to_yaml(LIBRARY_PATH, @@library)
  end

  def self.scan(directory)
    added = 0
    skipped = 0
    if Dir.exists? directory
      Dir.chdir(directory) do
        Dir.foreach(".") do |entry|
          if File.extname(entry) == ".mp3"
            song = Tagger.get_tags(entry)
            if already_have? song
              skipped += 1
            else
              puts "Adding #{song} to library."
              added += 1
              add song
            end
          else
          # do nothing
        end
      end

      puts "Added #{added} new songs and skipped #{skipped} existing ones."
    end

  else
    raise RuntimeError, "Couldn't find #{directory} for scanning."
  end
end

def self.queue(song)
end

def self.already_have?(song)
  setup
  check_for(song) || check_queue_for(song)
end

private

def self.setup
  load_library if @@library.nil?
  load_queue if @@queue.nil?
end

def self.load_library
  @@library = load_hash_from_yaml(LIBRARY_PATH)
end

def self.load_queue
  @@queue = load_hash_from_yaml(QUEUE_PATH)
end

def self.check_for(song)
  @@library.each do |lib_song|
    return true if match(song, lib_song)
  end
  return false
end

def self.check_queue_for(song)
  @@queue.each do |queue_song|
    return true if match(song, queue_song)
  end
  return false
end

def self.match(songA, songB)
  if songA[:remote_id] != nil && songA[:remote_id] == songB[:remote_id]
    true
  elsif songA[:artist] == songB[:artist] && songA[:title] == songB[:title]
    true
  elsif songA[:filename] == songB[:filename]
    true
  else
    false
  end
end

def self.save_hash_to_yaml(file, hash)
  FileUtils.mkdir_p(File.dirname(file))
  File.new(file, "w") unless File.exist? file
  File.open(file, "w") do |yaml_file|
    yaml_file.write(hash.to_yaml)
  end
end

def self.load_hash_from_yaml(file)
  File.new(file, "w") unless File.exist? file
  yaml_data = File.open(file, "r") do |handle|
    YAML.load(handle)
  end
  yaml_data = [] unless yaml_data
  return yaml_data
end

private_class_method :load_library, :load_queue, :save_hash_to_yaml, :load_hash_from_yaml, :check_for, :check_queue_for
private_class_method :match, :setup

end
