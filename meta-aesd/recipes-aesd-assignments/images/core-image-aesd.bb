inherit core-image
CORE_IMAGE_EXTRA_INSTALL += " openssh"

# Adding the package for camera driver
CORE_IMAGE_EXTRA_INSTALL += " camera"

# Adding the package for gpio driver
CORE_IMAGE_EXTRA_INSTALL += " gpio"

# Adding the package for mosquitto services
CORE_IMAGE_EXTRA_INSTALL += " mosquitto mosquitto-clients"

# Adding the package for motion detection application
CORE_IMAGE_EXTRA_INSTALL += " opencv-app-file"

# Adding the package for motion detection application
CORE_IMAGE_EXTRA_INSTALL += " gstreamer-scripts"

# Adding the package for MQTT application code
CORE_IMAGE_EXTRA_INSTALL += " mqtt"

# Adding output image format type
IMAGE_FSTYPES = "tar.xz ext3 rpi-sdimg"

# Enabling wifi feature 
DISTRO_FEATURES:append = " wifi"

# Adding wifi support in firmware
IMAGE_INSTALL:append = "wpa-supplicant"

# Adding the required dependencies for opencv
IMAGE_INSTALL:append = " opencv libopencv-core libopencv-imgproc"

# Adding the required dependencies for gstreamer
IMAGE_INSTALL:append = " v4l-utils python3 ntp fbida fbgrab ffmpeg imagemagick gstreamer1.0 gstreamer1.0-libav gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gst-player gstreamer1.0-meta-base gst-examples gstreamer1.0-rtsp-server"

inherit extrausers
# See https://docs.yoctoproject.org/singleindex.html#extrausers-bbclass
# We set a default password of root to match our busybox instance setup
# Don't do this in a production image
# PASSWD below is set to the output of
# printf "%q" $(mkpasswd -m sha256crypt root) to hash the "root" password
# string
PASSWD = "\$5\$2WoxjAdaC2\$l4aj6Is.EWkD72Vt.byhM5qRtF9HcCM/5YpbxpmvNB5"
EXTRA_USERS_PARAMS = "usermod -p '${PASSWD}' root;"
