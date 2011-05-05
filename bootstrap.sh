#! /bin/sh

if [ -n "$ROS_ROOT" ]; then
       echo "Error: ROS_ROOT detected. You should follow the installation instructions of the "
       echo " http://www.ros.org/wiki/orocos_toolchain_ros "
       echo " website or unset ROS_ROOT in order not to bootstrap for ROS. Note that there are"
       echo " also Debian packages for the Orocos Toolchain in the ros package repositories."
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
    $DOWNLOADER http://rock-robotics.org/autoproj_bootstrap
fi

ruby autoproj_bootstrap $@ git git://gitorious.org/orocos-toolchain/build.git branch=toolchain-2.3
. $PWD/env.sh
autoproj update
autoproj fast-build

