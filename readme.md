vid2mp3.rb
==========
(Version 1.0.0 -- March 2014)

Download, convert and tag mp3 files from youtube videos containing them.
Also keeps a "music library" listing all of the files which have been downloaded using this tool,
so that that listing can be queried and duplicate downloads avoided.

Usage: 
-------

* Download and convert immediately (also tries to parse the video name into title/artist and tag the mp3, and provides an opportunity to correct them):
  vid2mp3.rb download --- (Proceeds to query user for video url or id)
  vid2mp3.rb download {youtube video url}
  vid2mp3.rb {url}

* Add to batch download list (attempts to parse and tag video name into title/artist but doesn't ask the user for review.)
  vid2mp3.rb add --- (Proceeds to query user for video url or id)
  vid2mp3.rb add {url}

* Execute batch download (and presents title/artist for each and an opportunity to edit them.)
  vid2mp3.rb execute

* Scan a directory for mp3 files to add to the music library
  vid2mp3.rb scan {directory}

