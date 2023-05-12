#!/usr/bin/env sh

## define functions ##
Wall_Next()
{
    WallSet=`readlink $BASEDIR/images`
    Wallist=(`dirname $WallSet`/*)

    for((i=0;i<${#Wallist[@]};i++))
    do
        if [ $((i + 1)) -eq ${#Wallist[@]} ] ; then
            ln -fs ${Wallist[0]} $BASEDIR/wall.paper
            break
        elif [ ${Wallist[i]} == ${WallSet} ] ; then
            ln -fs ${Wallist[i+1]} $BASEDIR/wall.paper
            break
        fi
    done
}

Wall_Set()
{
    swww img $BASEDIR/wall.set \
    --transition-bezier .43,1.19,1,.4 \
    --transition-type grow \
    --transition-duration 1 \
    --transition-fps 144 \
    --transition-pos bottom-right
}

## main script ##
BASEDIR=`dirname $(realpath $0)`

## check linked file ##
# if [ ! -f $BASEDIR/wall.paper ] ; then
#     echo "ERROR: wallpaper link is broken"
#     exit 1
# fi

## evaluate options ##
while getopts "nt" option ; do
    case $option in
    n ) # set the next wallpaper
        Wall_Next ;;
    t ) # display tooltip
        echo "󰋫 Next Wallpaper 󰉼 󰆊"
        exit 0 ;;
    * ) # invalid option
        echo "n : set next wall"
        exit 1 ;;
    esac
done

## check swww daemon ##
swww query
if [ $? -eq 1 ] ; then
    swww init
    sleep 2.5
fi

## set wallpaper ##
Wall_Set
convert -scale 10% -blur 0x2.5 -resize 1000% $BASEDIR/wall.set $BASEDIR/wall.blur
