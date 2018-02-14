#!/bin/bash

OUTDIR=/var/callrec/`date +"%Y"`/`date +"%m"`/`date +"%d"`/rec
if [ ! -d $OUTDIR ]; then
	mkdir -p $OUTDIR
fi

TMPDIR=/tmp/asterisk

WAV1=$1
WAV2=$2
WAV=$(printf "%s\n" "$WAV1" "$WAV2" | sed -e 'N;s/^\(.*\).*\n\1.*$/\1/')
WAV=${WAV##*/}
MP3="$WAV.mp3"
WAV="$WAV.wav"
# Merge 2 wav files
sox -m $WAV1 $WAV2 $TMPDIR/$WAV

#cp $WAV1 $TMPDIR/
#cp $WAV2 $TMPDIR/

# Delete original 2 files
#rm -f $WAV1
#rm -f $WAV2


# Convert wav to mp3
lame --resample 16 --silent $TMPDIR/$WAV $OUTDIR/$MP3
# Delete wav file
rm -f $TMPDIR/$WAV

rsync -r /var/callrec/ /mnt/callrec
