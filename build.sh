#!/bin/bash
# Script to build image for qemu.
# Author: Siddhant Jajoo.

git submodule init
git submodule sync
git submodule update

# local.conf won't exist until this step on first execution
source poky/oe-init-build-env

################################################################
# Description : Set hardware configuration for RPI 3b+
# Author : Maanas Makam Dileep Kumar
# Date : 04/13/23
################################################################
CONFLINE="MACHINE = \"raspberrypi3-64\""

cat conf/local.conf | grep "${CONFLINE}" > /dev/null
local_conf_info=$?

if [ $local_conf_info -ne 0 ];then
	echo "Append ${CONFLINE} in the local.conf file"
	echo ${CONFLINE} >> conf/local.conf
	
else
	echo "${CONFLINE} already exists in the local.conf file"
fi

################################################################
# Description : Set the custom image output types
# Author : Maanas Makam Dileep Kumar
# Date : 04/13/23
################################################################
IMAGE="IMAGE_FSTYPES = \"tar.xz ext3 rpi-sdimg\""

cat conf/local.conf | grep "${IMAGE}" > /dev/null
local_image_info=$?

if [ $local_image_info -ne 0 ];then 
    echo "Append ${IMAGE} in the local.conf file"
	echo ${IMAGE} >> conf/local.conf
else
	echo "${IMAGE} already exists in the local.conf file"
fi

bitbake-layers show-layers | grep "meta-aesd" > /dev/null
layer_info=$?

if [ $layer_info -ne 0 ];then
	echo "Adding meta-aesd layer"
	bitbake-layers add-layer ../meta-aesd
else
	echo "meta-aesd layer already exists"
fi

################################################################
# Description : Adding meta-raspberrypi layer.
# Author : Maanas Makam Dileep Kumar
# Date : 04/13/23
################################################################
bitbake-layers show-layers | grep "meta-raspberrypi" > /dev/null
layer_raspberrypi_info=$?

if [ $layer_raspberrypi_info -ne 0 ];then
	echo "Adding meta-raspberrypi layer"
	bitbake-layers add-layer ../poky/meta-raspberrypi
else
	echo "meta-raspberrypi layer already exists"
fi

set -e
bitbake core-image-aesd
