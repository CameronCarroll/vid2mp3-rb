1.2.0, 3/18/14
--------------
* Changed split method (youtube title string split into artist and title) to include spaces, which allows for names that have dashes in them.
* Added a prompt to manually add artist, title, filename info in case we can't get a title string from viddl-rb (like in the case of ampersands...)

1.1.0, 3/9/14
--------------
* Added rudimentary 'music library' functionality to keep track of what we've already downloaded, since download and conversion takes a little while. Anything downloaded is automatically added to a flat yaml file containing everything downloded.
* Added a scan command which adds all mp3s in a directory to the music library.
* Removed debugging printouts and pry require statements. (Development cruft.)
* Youtube video title is now printed out before its attempted decomposition.
* Fixed up reading relative files, allowing script to be used from a pwd other than its own directory.
* Calling 'add' or 'download' without any further arguments prompts the user for it instead of quitting.