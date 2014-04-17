#!/bin/bash

#load configs
. config.sh

echo "--------------------------"
echo "Downloading Podcast Audio & Feed"
echo "--------------------------"

#get the RSS feed and all of its enclosures
wget -q -O- $SRC_FEED | grep -o '<enclosure url="[^"]*' | grep -o '[^"]*$' | xargs wget -nc -T 15 -c --directory-prefix=out
wget -q -O- $SRC_FEED  > out/index.xml

#convert the files to mp3
echo "--------------------------"
echo "Converting Audio to MP3 (this may take a minute)"
echo "--------------------------"

if [ "$(ls -A out/*.aiff)" ]; then

    cd out
    for i in *.aiff;
      do name=`echo $i | cut -d'.' -f1`;
      echo "Converting $i..."
      ffmpeg -y -v error -i $i -b 192k $name.mp3

      rm $i
    done
    cd ../

else
    echo "There were no generated aiff files. Check your settings."
    exit
fi

echo "--------------------------"
echo "Changing paths in Feed"
echo "--------------------------"

#update the paths in the RSS feed
sed -i '' "s/${SRC_FEED//\//\\/}/${DEST_FEED//\//\\/}/g" out/index.xml

#change aiff references to mp3 references.
sed -i '' "s/\.aiff\"/.mp3\"/g" out/index.xml
sed -i '' "s/\/aiff/\/mp3/g" out/index.xml

echo "--------------------------"
echo "Rscynch-ing files"
echo "--------------------------"

#rsync the goodies to its new home
rsync  --progress -avz out/ $DEST_RSYNC

# inform the user things are done
echo "--------------------------"
echo "Done. Readomator Podcast Downloaded & Rsync'd. "
echo " Your podcast is available at $DEST_FEED/index.xml"
echo "--------------------------"

