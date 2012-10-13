#!/bin/bash

BASEDIR=/var/repos/ntp-dev-factory
OLD=ntp-dev-4.2.7
CHLG=$BASEDIR/chlg
NTPAUTHOR="Harlan Stenn <stenn@ntp.org>"

cd $BASEDIR

for x in $(ls -d ntp-dev-4.2.7p* |sort -V )
do
    VER=$(echo $x|cut -f 3 -d \-)
    cd $BASEDIR/$x
    mv $BASEDIR/$OLD/.git  $BASEDIR/$x

	LOGDATE=$(date -r ChangeLog +%s)

    git diff ChangeLog |grep ^+|grep -v b/ChangeLog|cut -c 2- |tail -n +2 > $CHLG
    git add -A
    git commit --author="$NTPAUTHOR" --date="$LOGDATE" -F $CHLG
    git tag  -F $CHLG $VER

    OLD=$x
done


echo cp -r /$BASEDIR/$x $BASEDIR/ntp-mirror-updated
cp -r /$BASEDIR/$x $BASEDIR/ntp-mirror-updated

