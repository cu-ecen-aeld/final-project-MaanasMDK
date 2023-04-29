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
# DISTRO_F="DISTRO_FEATURES:append = \" wifi\""

# cat conf/local.conf | grep "${DISTRO_F}" > /dev/null
# local_distro_info=$?

# if [ $local_distro_info -ne 0 ];then
#     echo "Append ${DISTRO_F} in the local.conf file"
# 	echo ${DISTRO_F} >> conf/local.conf
# else
# 	echo "${DISTRO_F} already exists in the local.conf file"
# fi

# # Adding firmware support for wifi, opencv, and Gstreamer
# IMAGE_ADD="IMAGE_INSTALL:append = \"wpa-supplicant opencv libopencv-core libopencv-imgproc
# 									v4l-utils python3 ntp
# 									fbida fbgrab ffmpeg imagemagick gstreamer1.0
# 									gstreamer1.0-libav gstreamer1.0-plugins-base
# 									gstreamer1.0-plugins-good gstreamer1.0-plugins-bad  
# 									gstreamer1.0-plugins-ugly  gst-player 
# 									gstreamer1.0-meta-base gst-examples gstreamer1.0-rtsp-server\""

# cat conf/local.conf | grep "${IMAGE_ADD}" > /dev/null
# local_imgadd_info=$?

# if [ $local_imgadd_info -ne 0 ];then
#     echo "Append ${IMAGE_ADD} in the local.conf file"
# 	echo ${IMAGE_ADD} >> conf/local.conf
# else
# 	echo "${IMAGE_ADD} already exists in the local.conf file"
# fi

################################################################
# Description : Adding licencing information
# Author : Maanas Makam Dileep Kumar
# Date : 04/19/23
################################################################
LICENCE="LICENSE_FLAGS_ACCEPTED  = \"commercial commercial_gstreamer1.0-plugins-ugly\""
# LICENCE_APPEND="LICENSE:append = \" commercial_gstreamer1.0-plugins-ugly commercial_mpg123\""

cat conf/local.conf | grep "${LICENCE}" > /dev/null
local_licn_info=$?

if [ $local_licn_info -ne 0 ];then
    echo "Append ${LICENCE} in the local.conf file"
	echo ${LICENCE} >> conf/local.conf
	#echo ${LICENCE_APPEND} >> conf/local.conf
else
	echo "${LICENCE} already exists in the local.conf file"
fi

# # Adding required gstreamer Package_configs for x264 to local.conf file
# cat conf/local.conf | grep "x264" > /dev/null
# local_licn_info=$?

# if [ $local_licn_info -ne 0 ];then
#     echo "Append x264 PACKAGECONFIG to local.conf file"
#          echo "PACKAGECONFIG:append:pn-gstreamer1.0-plugins-ugly = \" x264\"" >> conf/local.conf
# else
#          echo " x264 package congigurations already exists in local.conf"
# fi

# # Adding required gstreamer Package_configs for voaacenc to local.conf file
# cat conf/local.conf | grep " voaacenc" > /dev/null
# local_licn_info=$?

# if [ $local_licn_info -ne 0 ];then
#     echo "Append voaacenc PACKAGECONFIG to local.conf file"
#          echo "PACKAGECONFIG:append:pn-gstreamer1.0-plugins-bad = \" voaacenc\"" >> conf/local.conf
# else
#          echo " voaacenc package congigurations already exists in local.conf"
# fi

# # Adding required gstreamer Package_configs for rtmp to local.conf file
# cat conf/local.conf | grep " rtmp" > /dev/null
# local_licn_info=$?

# if [ $local_licn_info -ne 0 ];then
#     echo "Append rtmp PACKAGECONFIG to local.conf file"
#          echo "PACKAGECONFIG:append:pn-gstreamer1.0-plugins-bad = \" rtmp\"" >> conf/local.conf
# else
#          echo " rtmp package congigurations already exists in local.conf"
# fi

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

################################################################
# Description : Adding meta-multimedia layer.
# Author : Maanas Makam Dileep Kumar
# Date : 04/19/23
################################################################
bitbake-layers show-layers | grep "meta-multimedia" > /dev/null
layer_multimedia_info=$?

if [ $layer_multimedia_info -ne 0 ];then
	echo "Adding meta-multimedia layer"
	bitbake-layers add-layer ../meta-openembedded/meta-multimedia
else
	echo "meta-multimedia layer already exists"
fi

################################################################
# Description : Adding meta-qt5 layer.
# Author : Maanas Makam Dileep Kumar
# Date : 04/19/23
################################################################
bitbake-layers show-layers | grep "meta-qt5" > /dev/null
layer_qt5_info=$?

if [ $layer_qt5_info -ne 0 ];then
	echo "Adding meta-qt5 layer"
	bitbake-layers add-layer ../meta-qt5
else
	echo "meta-qt5 layer already exists"
fi

set -e
bitbake core-image-aesd
