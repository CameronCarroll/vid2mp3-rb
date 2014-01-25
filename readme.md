vid2mp3.rb
==========
(Version 1.0.0 -- January 2014)

Download, convert and tag mp3 files from youtube videos containing them.

Usage: 
-------

* Download and convert immediately (also tries to parse the video name into title/artist and tag the mp3, and provides an opportunity to correct them):
  vid2mp3.rb {youtube video url}

* Add to batch download list (attempts to parse and tag video name into title/artist but doesn't ask the user for review.)
  vid2mp3.rb add {youtube video url}

* Execute batch download (and presents title/artist for each and an opportunity to edit them.)
  vid2mp3.rb execute
