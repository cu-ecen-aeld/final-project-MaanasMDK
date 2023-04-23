# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

# WARNING: the following LICENSE and LIC_FILES_CHKSUM values are best guesses - it is
# your responsibility to verify that the values are complete and correct.
#
# The following license files were not able to be identified and are
# represented as "Unknown" below, you will need to check them yourself:
#   LICENSE
LICENSE = "MIT"
#LIC_FILES_CHKSUM = "file://LICENSE;md5=f098732a73b5f6f3430472f5b094ffdb"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://git@github.com/cu-ecen-aeld/final-project-KhyatiSatta;protocol=ssh;branch=main \
file://S98lddmodules-gpio-start-stop.sh"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "af08560aae357d7b52c8c622f6988ec00b6b7a05"

S = "${WORKDIR}/git/gpio"

inherit module

MODULES_INSTALL_TARGET = "install"
EXTRA_OEMAKE:append_task-install = " -C ${STAGING_KERNEL_DIR} M=${S}/aesd_gpio"
EXTRA_OEMAKE += "KERNELDIR=${STAGING_KERNEL_DIR}"

inherit update-rc.d
INITSCRIPT_PACKAGES = "${PN}"
INITSCRIPT_NAME:${PN} = "S98lddmodules-gpio-start-stop.sh"

FILES:${PN} += "${bindir}/aesdgpio_load"
FILES:${PN} += "${bindir}/aesdgpio_unload"
FILES:${PN} += "${sysconfdir}/*"

do_configure () {
	:
}

do_compile () {
	oe_runmake
}

do_install () {
	# TODO: Install your binaries/scripts here.
	# Be sure to install the target directory with install -d first
	# Yocto variables ${D} and ${S} are useful here, which you can read about at 
	# https://docs.yoctoproject.org/ref-manual/variables.html?highlight=workdir#term-D
	# and
	# https://docs.yoctoproject.org/ref-manual/variables.html?highlight=workdir#term-S
	# See example at https://github.com/cu-ecen-aeld/ecen5013-yocto/blob/ecen5013-hello-world/meta-ecen5013/recipes-ecen5013/ecen5013-hello-world/ecen5013-hello-world_git.bb
	install -d ${D}${bindir}
	install -d ${D}${sysconfdir}/init.d
    install -d ${D}${base_libdir}/modules/5.15.34-v8/
	install -m 0755 ${S}/aesdgpio_load ${D}${bindir}/
    install -m 0755 ${S}/aesdgpio_unload ${D}${bindir}/
	install -m 0755 ${WORKDIR}/S98lddmodules-gpio-start-stop.sh ${D}${sysconfdir}/init.d
    install -m 0755 ${S}/aesdgpio.ko ${D}/${base_libdir}/modules/5.15.34-v8/
}