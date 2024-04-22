#!/bin/bash

#
# Usage:
#
# downsample-mp3s.sh /Music/Albums /media/usb-stick
#
# Copies any mp3 deep within the source tree to the top level
# of the target directory, downsampling each one to 128k.
#

source="$1"
dest="$2"

for mp3 in $(find "$source" -name "*.mp3") ; do 
	f=$(basename "$mp3")

	if [ ! -f "$dest/$f" ] ; then
		echo ffmpeg -i "$mp3" -c:a libmp3lame -b:a 128k "$dest/$f"
	fi
done
