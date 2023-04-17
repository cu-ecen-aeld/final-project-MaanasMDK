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
	bitbake-layers add-layer ../meta-raspberrypi
else
	echo "meta-raspberrypi layer already exists"
fi

################################################################
# Description : Adding support for wifi
# Author : Maanas Makam Dileep Kumar
# Date : 04/14/23
################################################################
# Adding DISTRO_FEATURE wifi
DISTRO_F="DISTRO_FEATURES:append = \" wifi\""

cat conf/local.conf | grep "${DISTRO_F}" > /dev/null
local_distro_info=$?

if [ $local_distro_info -ne 0 ];then
    echo "Append ${DISTRO_F} in the local.conf file"
	echo ${DISTRO_F} >> conf/local.conf
else
	echo "${DISTRO_F} already exists in the local.conf file"
fi

# Adding firmware support for wifi
IMAGE_ADD="IMAGE_INSTALL:append = \"wpa-supplicant\""

cat conf/local.conf | grep "${IMAGE_ADD}" > /dev/null
local_imgadd_info=$?

if [ $local_imgadd_info -ne 0 ];then
    echo "Append ${IMAGE_ADD} in the local.conf file"
	echo ${IMAGE_ADD} >> conf/local.conf
else
	echo "${IMAGE_ADD} already exists in the local.conf file"
fi

################################################################
# Description : Adding meta-oe layer.
# Author : Maanas Makam Dileep Kumar
# Date : 04/14/23
################################################################
bitbake-layers show-layers | grep "meta-oe" > /dev/null
layer_oe_info=$?

if [ $layer_oe_info -ne 0 ];then
	echo "Adding meta-oe layer"
	bitbake-layers add-layer ../meta-openembedded/meta-oe
else
	echo "meta-oe layer already exists"
fi

################################################################
# Description : Adding meta-python layer.
# Author : Maanas Makam Dileep Kumar
# Date : 04/14/23
################################################################
bitbake-layers show-layers | grep "meta-python" > /dev/null
layer_python_info=$?

if [ $layer_python_info -ne 0 ];then
	echo "Adding meta-python layer"
	bitbake-layers add-layer ../meta-openembedded/meta-python
else
	echo "meta-python layer already exists"
fi

################################################################
# Description : Adding meta-networking layer.
# Author : Maanas Makam Dileep Kumar
# Date : 04/14/23
################################################################
bitbake-layers show-layers | grep "meta-networking" > /dev/null
layer_networking_info=$?

if [ $layer_networking_info -ne 0 ];then
	echo "Adding meta-networking layer"
	bitbake-layers add-layer ../meta-openembedded/meta-networking
else
	echo "meta-networking layer already exists"
fi

set -e
bitbake core-image-aesd
