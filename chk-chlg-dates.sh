#!/bin/bash

BASEDIR=/var/repos/ntp-dev-factory
OLD=ntp-mirror
CHLG=$BASEDIR/chlg

cd $BASEDIR

for x in $(ls -d ntp-dev-4.2.7p* |sort -V )

do
	CL=$BASEDIR/$x/ChangeLog
	LOGDATE=$(head -1 $CL | cut -f 2 -d " ")
	FILEDATE=$(date -r $CL +%Y/%m/%d)
    VER=$(echo $x|cut -f 3 -d \-)

	if [ "$LOGDATE" != "$FILEDATE" ]; then
		echo "Problem with $VER:"
		echo "$LOGDATE not equal to $FILEDATE"
	fi

done


