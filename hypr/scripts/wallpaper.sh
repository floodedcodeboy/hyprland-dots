#!/usr/bin/env sh

## main script ##
BASEDIR=`dirname $(realpath $0)`

## check swww daemon ##
swww query
if [ $? -eq 1 ] ; then
    swww init
    sleep 2.5
fi

BEZIER=.43,0.1,1,.4

## set wallpaper ##
swww img $1 \
    --transition-bezier ${BEZIER} \
    --transition-type grow \
    --transition-duration 1 \
    --transition-fps 144 \
    --transition-pos bottom-right
