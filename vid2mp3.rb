#!/usr/bin/ruby

# vid2mp3.rb -- Cameron Carroll, 2015
# Purpose: Download videos from Youtube, strips off the audio into an mp3 and attempts to tag it by artist & title.

require 'rubygems'
require 'bundler/setup'

require 'cgi'
require 'uri'
require 'fileutils'

require_relative 'lib/argparser'
require_relative 'lib/handler'

VERSION = File.read(File.join(__dir__, 'VERSION'))

# User Configuration Section: -------------------------------------------------
# No-Argument Behavior: Specifies what happens when you don't invoke a particular command.
# [:download or :add]
DEFAULT_BEHAVIOR = :download
<<<<<<< HEAD
SAVE_PATH = ENV['HOME'] + "/music/library/"
LIBRARY_PATH = ENV['HOME'] + "/music/.library"
QUEUE_PATH = ENV['HOME'] + "/music/.queue"
=======
# Paths for downloads and working files.
SAVE_PATH = "#{ENV['HOME']}/music/"
LIBRARY_PATH = "#{ENV['HOME']}/music/.library"
QUEUE_PATH = "#{ENV['HOME']}/music/.queue"
>>>>>>> a90659c990ab4f8afa5db69400cbb5b634af96f9
# -----------------------------------------------------------------------------

# So this is like almost two years later, I have absolutely no idea
# where I should put this. All of the divisions of responsibilty seem so silly
# and arbitrary, but we never actually made the above directories programatically.
# I just did it by hand every time because I'm dumb. Anyway here go:
FileUtils.mkdir_p SAVE_PATH

opts = ArgParser.parse_options
Handler.handle_behavior(opts)
