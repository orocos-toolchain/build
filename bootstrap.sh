#! /bin/sh

if [ -n "$ROS_ROOT" ]; then
       echo "Error: ROS_ROOT detected. You should follow the installation instructions of the "
       echo " http://www.ros.org/wiki/orocos_toolchain_ros "
       echo " website or unset ROS_ROOT in order not to bootstrap for ROS. Note that there are"
       echo " also Debian packages for the Orocos Toolchain in the ros package repositories."
       exit 1
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
    $DOWNLOADER http://rock-robotics.org/stable/autoproj_bootstrap
fi

tellfailupdate () {
    echo "autoproj failed to update your configuration. This means most of the time that there"
    echo "was an temporary network problem. You can try to manually complete the bootstrap by"
    echo "typing these three commands::"
    echo " . env.sh"
    echo " autoproj update"
    echo " autoproj fast-build"
    exit 1
}

tellfailbuild () {
    echo "autoproj failed to build your configuration. This means most of the time that there"
    echo "is a problem with the sources. You can try to manually complete the bootstrap by"
    echo "typing these two commands:"
    echo " . env.sh"
    echo " autoproj build"
    echo "If that does not work, send an email to the Orocos user's mailing list: orocos-users@mech.kuleuven.be"
    exit 1
}

ruby autoproj_bootstrap $@ git git://gitorious.org/orocos-toolchain/build.git branch=toolchain-2.6 push_to=git@gitorious.org:orocos-toolchain/build.git
. $PWD/env.sh
autoproj update || tellfailupdate
autoproj fast-build || tellfailbuild

