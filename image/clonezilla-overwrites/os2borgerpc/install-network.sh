#!/bin/sh

# Newer versions of Clonezilla use a different mountpoint for the disk; emulate
# the old one if it couldn't be found
if [ ! -d /live/image/ ]; then
    sudo mkdir -p /live
    sudo ln --symbolic /lib/live/mount/medium /live/image
fi

sudo dhclient -v eth0
if [ $? -ne 0 ]; then
    echo "Could get an IP address, exiting";
    exit 1;
fi

sudo /usr/bin/perl /live/image/os2borgerpc/mount_network_image.pl
if [ $? -ne 0 ]; then
    echo "Could not mount network image, exiting";
    exit 1;
fi

DEV=`sudo /usr/bin/perl /live/image/os2borgerpc/find_disk.pl`
if [ "" == "$DEV" ]; then
    echo "Could not find a device, exiting";
    exit 1;
fi

SWAPSIZE=`sudo /usr/bin/perl /live/image/os2borgerpc/get_swap_size.pl`
if [ "" == "$SWAPSIZE" ]; then
    echo "Could not find swap size, exiting";
    exit 1;
fi


sudo /usr/bin/perl /live/image/os2borgerpc/partition_disk.pl $DEV $SWAPSIZE
if [ $? -ne 0 ]; then
    echo "Partitioning failed, exiting";
    exit 1;
fi

IMAGE=`sudo /usr/bin/perl /live/image/os2borgerpc/select_image.pl`;
if [ $? -ne 0 ]; then
    echo "No image selected, exiting";
    exit 1;
fi

sudo /usr/bin/perl /live/image/os2borgerpc/clone_image.pl $DEV $IMAGE

sudo /usr/bin/perl /live/image/os2borgerpc/fix_swap.pl $DEV

sudo reboot



# old code
#echo Magenta2011 | sudo sshfs -p 22000 magenta@cloud.fleten.net:/home/magenta /home/partimag -o workaround=rename -o password_stdin
#/opt/drbl/sbin/ocs-sr -g auto -e1 auto -e2 -c -r -j2 -p true restoredisk current sda
#sudo reboot

