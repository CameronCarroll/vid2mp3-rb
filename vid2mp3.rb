#!/usr/bin/ruby

# vid2mp3.rb -- Cameron Carroll, 2014
# Purpose: Download videos from Youtube, strips off the audio into an mp3 and attempts to tag it.

require 'cgi'
require 'uri'
require 'pry'

require_relative 'lib/argparser'
require_relative 'lib/handler'

VERSION = File.read(File.join(__dir__, 'VERSION'))


# User Configuration Section: -------------------------------------------------
# No-Argument Behavior [:download or :add]
DEFAULT_BEHAVIOR = :download
SAVE_PATH = "/home/cameron/music/library/"
LIBRARY_PATH = "/home/cameron/music/.library"
QUEUE_PATH = "/home/cameron/music/.queue"
# -----------------------------------------------------------------------------

opts = ArgParser.parse_options
Handler.handle_behavior(opts)