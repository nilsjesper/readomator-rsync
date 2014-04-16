#!/bin/bash

#load configs
. config.sh

#get the RSS feed and all of its enclosures
wget -q -O- $SRC_FEED | grep -o '<enclosure url="[^"]*' | grep -o '[^"]*$' | xargs wget -c --directory-prefix=out
wget -q -O- $SRC_FEED  > out/index.xml

#update the paths in the RSS feed
sed -i '' "s/${SRC_FEED//\//\\/}/${DEST_FEED//\//\\/}/g" out/index.xml

#rsync the goodies to its new home
rsync -avz out/ $DEST_RSYNC

# inform the user things are done
echo "Readomator Podcast Downloaded & Rsync'd.  Your podcast is available at $DEST_FEED/index.xml"
