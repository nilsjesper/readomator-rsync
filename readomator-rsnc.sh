#!/bin/bash

. config.sh

wget -q -O- $SRC_FEED | grep -o '<enclosure url="[^"]*' | grep -o '[^"]*$' | xargs wget -c --directory-prefix=out
wget -q -O- $SRC_FEED  > out/index.xml

src="${SRC_FEED//\//\\/}"
dest="${DEST_FEED//\//\\/}"
sed -i '' "s/$src/$dest/g" out/index.xml

rsync -avz out/ $DEST_RSYNC

echo "Readomator Podcast Downloaded & Rsync'd"
