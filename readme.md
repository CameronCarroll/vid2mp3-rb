vid2mp3.rb
==========
(Version 1.2.2 -- June 2014)

* Convert Youtube videos into tagged MP3 files!
* Keeps a list of files in music library to avoid duplicates.

Requirements:
--------------

* Ruby (tested with 2.1)
* RubyGems with Bundler installed.
* ffmpeg (system)
* taglib (system)
* viddl-rb (rubygem)
* taglib-rb (rubygem)

Youtube Title Requirements:
---------------------------

All the logic to parse the youtube title into song info depends on a specific format:

[Artist] - [Title]  ([Optional Note 1]) ... ([Optional Note N])

Installation:
--------------

1. Install ffmpeg and taglib on your system. 
2. Download and extract tarball
3. Run 'bundle' in the downloaded folder to install gem dependencies.

Please note that you have to install gems to the system and not to vendor/bundle unless you want to CD to the app directory every time to use it.
4. Use in place or symlink your favorite bin PATH.

Usage: 
-------

* Download and convert immediately (also tries to parse the video name into title/artist and tag the mp3, and provides an opportunity to correct them):

  vid2mp3.rb download --- (Proceeds to query user for video url or id)

  vid2mp3.rb download {youtube video url}

  vid2mp3.rb {url}

* Add to batch download list (attempts to parse and tag video name into title/artist but doesn't ask the user for review.)

  (NOT IMPLEMENTED YET)

  vid2mp3.rb add --- (Proceeds to query user for video url or id)

  vid2mp3.rb add {url}

* Execute batch download (and presents title/artist for each and an opportunity to edit them.)

  (NOT IMPLEMENTED YET)
  
  vid2mp3.rb execute

* Scan a directory for mp3 files to add to the music library

  vid2mp3.rb scan {directory}

Future Functionality:
----------------------
I wanted to have a batch download function where you can quickly add a number of videos at once and then review them all at the same time and make changes accordingly. After you're satisfied, you can actually execute all the downloads and conversions and everything.

Contributors:
--------------

* gbaptista
