inherit core-image
#CORE_IMAGE_EXTRA_INSTALL += " aesd-assignments"
CORE_IMAGE_EXTRA_INSTALL += " openssh"
CORE_IMAGE_EXTRA_INSTALL += " camera"
CORE_IMAGE_EXTRA_INSTALL += " opencv-app"
CORE_IMAGE_EXTRA_INSTALL += " gpio x264"
CORE_IMAGE_EXTRA_INSTALL += " ldd"
CORE_IMAGE_EXTRA_INSTALL += " mosquitto mosquitto-clients"

inherit extrausers
# See https://docs.yoctoproject.org/singleindex.html#extrausers-bbclass
# We set a default password of root to match our busybox instance setup
# Don't do this in a production image
# PASSWD below is set to the output of
# printf "%q" $(mkpasswd -m sha256crypt root) to hash the "root" password
# string
PASSWD = "\$5\$2WoxjAdaC2\$l4aj6Is.EWkD72Vt.byhM5qRtF9HcCM/5YpbxpmvNB5"
EXTRA_USERS_PARAMS = "usermod -p '${PASSWD}' root;"
