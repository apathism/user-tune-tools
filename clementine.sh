#!/bin/bash

TUNEFILE=~/.psi/tune
TEMPFILE=~/.psi/temptune

while [ 1 ]; do
	qdbus org.mpris.clementine /Player GetMetadata > $TEMPFILE
	TEMPMETA=`cat $TEMPFILE`
	if [ "$TEMPMETA" = "" ]; then
		rm -f $TUNEFILE
	else
		cat $TEMPFILE | sed -n '5p' | sed -e "s/title: //" > $TUNEFILE
		cat $TEMPFILE | sed -n '2p' | sed -e "s/artist: //" >> $TUNEFILE
		cat $TEMPFILE | sed -n '1p' | sed -e "s/album: //" >> $TUNEFILE
		cat $TEMPFILE | sed -n '6p' | sed -e "s/tracknumber: //" >> $TUNEFILE
		cat $TEMPFILE | sed -n '4p' | sed -e "s/time: //" >> $TUNEFILE
		rm -f $TEMPFILE
	fi
	sleep 5
done
