#!/usr/bin/ruby

# vid2mp3.rb -- Cameron Carroll, 2014
# Purpose: Download videos from Youtube, strips off the audio into an mp3 and attempts to tag it.

require 'cgi'
require 'uri'
require 'pry'

require_relative 'lib/argparser'
require_relative 'lib/handler'

VERSION = File.read('./VERSION')

# User Configuration Section: -------------------------------------------------
# No-Argument Behavior [:download or :add]
DEFAULT_BEHAVIOR = :download
# -----------------------------------------------------------------------------

opts = ArgParser.parse_options
Handler.handle_behavior(opts)