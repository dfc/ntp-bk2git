#!/bin/bash

BASEDIR=/var/repos/ntp-dev-factory
OLD=ntp-mirror
CHLG=$BASEDIR/chlg

cd $BASEDIR

for x in $(ls -d ntp-dev-4.2.7p* |sort -V )
do
    VER=$(echo $x|cut -f 3 -d \-)
    cd $BASEDIR/$x
    mv $BASEDIR/$OLD/.git  $BASEDIR/$x
    git diff ChangeLog |grep ^+|grep -v b/ChangeLog|cut -c 2- |tail -n +2 > $CHLG
    git add -A
    cat $CHLG  |git commit --author="Harlan Stenn <stenn@ntp.org>" -F -
    cat $CHLG  |git tag  -F - $VER
    OLD=$x
done


echo cp -r /$BASEDIR/$x $BASEDIR/ntp-mirror-updated
cp -r /$BASEDIR/$x $BASEDIR/ntp-mirror-updated

