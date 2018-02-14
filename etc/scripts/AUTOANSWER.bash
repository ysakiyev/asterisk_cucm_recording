#!/bin/bash

OUTDIR=/var/callrec/`date +"%Y"`/`date +"%m"`/`date +"%d"`/autoanswer
if [ ! -d $OUTDIR ]; then
	mkdir -p $OUTDIR
fi

TMPDIR=/tmp/asterisk

WAV=$1
MP3=${WAV##*/}
MP3="${MP3/.wav/.mp3}"

# Convert wav to mp3
lame --resample 16 --silent $WAV $OUTDIR/$MP3
# Delete wav file
#rm -f $WAV

rsync -r /var/callrec/ /mnt/callrec
