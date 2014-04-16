readomator-rsync
================

A bash script which will download &amp; rsync your local Readomator podcast for consumption by podcatchers other than iTunes

## Background
Readomator ( http://www.graygoolabs.com/readomator/ ) is a fantastic piece of software which takes your saved Instapaper ( http://instapaper.com ) list of saved articles and creates a podcast using your Mac's built in text-to-speech capabilities.  The only problem is that it is only built to sync locally with iTunes and for people like myself who don't use iTunes, that stinks.

This bash script will slurp down the generated AIFF audio files and the RSS feed document itself and use rsync to move them to a destination of your choice, such as a webserver which you can then point your favorite podcast app to.

## Configuration

Rename config.sh.sample to config.sh and update the following values:

* SRC_FEED - This is the URL to your local Readomator podcast RSS feed.  All you should need to do here is update the example string with your Instapaper username.
* DEST_FEED - The web accessible URL where your rsync'd feed will live.  Note, you only need the directory and no trailing slash.
* DEST_RSYNC - the "destination" portion of the rsync command.  Assuming you're rsyncing this to a remote server, this will need the username@hostname:/path/to/the/dest/feed/you/entered/above

## Installing & Running

* Clone this project
* In Terminal or your console program of choice, go to the newly cloned directory
* ./readomator-synch.sh
* Sit back and watch the fireworks.  If everything is successfull, your new script should be available at DEST_FEED/index.html

## TODO

Lots! This was just the result of a distracted afternoon of hacking when I should have been doing other things at work.  Configuring the output directory would be a good start.  Other suggestions welcome.

