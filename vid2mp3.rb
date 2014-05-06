#!/usr/bin/ruby

# vid2mp3.rb -- Cameron Carroll, 2014
# Purpose: Download videos from Youtube, strips off the audio into an mp3 and attempts to tag it by artist & title.

require 'rubygems'
require 'bundler/setup'

require 'cgi'
require 'uri'

require_relative 'lib/argparser'
require_relative 'lib/handler'

VERSION = File.read(File.join(__dir__, 'VERSION'))


# User Configuration Section: -------------------------------------------------
# No-Argument Behavior: Specifies what happens when you don't invoke a particular command.
# [:download or :add]
DEFAULT_BEHAVIOR = :download
# Paths for downloads and working files.
SAVE_PATH = "/home/cameron/music/library/"
LIBRARY_PATH = "/home/cameron/music/.library"
QUEUE_PATH = "/home/cameron/music/.queue"
# -----------------------------------------------------------------------------

opts = ArgParser.parse_options
Handler.handle_behavior(opts)
