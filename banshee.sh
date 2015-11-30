#!/bin/bash

TUNEFILE=~/.psi/tune
STAGE1=~/.psi/tunestage1
STAGE2=~/.psi/tunestage2

while [ 1 ]; do
	isrunning=`ps -A | grep banshee-1`
	if [ "$isrunning" = "" ]; then
		rm -f $TUNEFILE
	else
		banshee --query-current-state --query-title --query-artist --query-album --query-track-number --query-duration > $STAGE1
		state=`cat $STAGE1 | sed -n '1p'`
		if [ "$state" = "current-state: playing" ] || [ "$state" = "current-state: paused" ]; then
			cat $STAGE1 | sed -n '2p' | sed -e "s/title: //" > $STAGE2
			cat $STAGE1 | sed -n '3p' | sed -e "s/artist: //" >> $STAGE2
			cat $STAGE1 | sed -n '4p' | sed -e "s/album: //" >> $STAGE2
			cat $STAGE1 | sed -n '5p' | sed -e "s/track-number: //" >> $STAGE2
			cat $STAGE1 | sed -n '6p' | sed -e "s/duration: //" | sed -e "s/,[0-9]*$//" >> $STAGE2
			rm -f $STAGE1
			cp $STAGE2 $TUNEFILE
			rm -f $STAGE2
		else
			rm -f $TUNEFILE
		fi
	fi
	sleep 5
done
