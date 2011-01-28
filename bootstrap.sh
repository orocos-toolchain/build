#! /bin/sh

if [ -n "$ROS_ROOT" ]; then
   for i in $(echo $ROS_PACKAGE_PATH | sed -e's/:/ /g'); do if expr match "`pwd`" "$i"; then path_ok=1; fi; done > /dev/null
   if [ -n $path_ok  ]; then
       echo "Error: ROS_ROOT detected, but '$(pwd)' is not in your ROS_PACKAGE_PATH"
       echo " Please run this script in a sub-directory of ROS_PACKAGE_PATH (='$ROS_PACKAGE_PATH')"
       echo " or unset ROS_ROOT in order not to bootstrap for ROS."
       exit 1
   fi
fi

if ! test -f $PWD/autoproj_bootstrap; then
    if which wget > /dev/null; then
        DOWNLOADER=wget
    elif which curl > /dev/null; then
        DOWNLOADER=curl
    else
        echo "I can find neither curl nor wget, either install one of these or"
        echo "download the following script yourself, and re-run this script"
        exit 1
    fi
    $DOWNLOADER http://doudou.github.com/autoproj/autoproj_bootstrap
fi

ruby autoproj_bootstrap $@ git git://gitorious.org/orocos-toolchain/build.git branch=toolchain-2.2
. $PWD/env.sh
autoproj update
autoproj fast-build

