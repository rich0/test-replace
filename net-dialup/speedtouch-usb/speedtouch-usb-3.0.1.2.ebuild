# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/speedtouch-usb/speedtouch-usb-3.0.1.2.ebuild,v 1.2 2006/03/19 15:29:18 mrness Exp $

inherit eutils linux-info

DESCRIPTION="Firmware and configuration instructions for the kernel-space driver for Alcatel SpeedTouch USB modems"
HOMEPAGE="http://www.speedtouch.com/"
SRC_URI="http://www.speedtouch.com/download/drivers/USB/SpeedTouch330_firmware_${PV//./}.zip"

# Taken from http://www.speedtouch.com/driver_upgrade_lx_3.0.1.2.htm
LICENSE="SpeedTouch-USB-Firmware"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=net-dialup/ppp-2.4.3-r11
	>=sys-fs/udev-086
	!net-dialup/speedtouch"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 6 10 ; then
		eerror "The kernel-space driver exists only in kernels >= 2.6.10."
		eerror "Please emerge net-dialup/speedtouch instead or upgrade the kernel."
		die "Unsupported kernel version"
	fi

	if ! has_version '>=sys-apps/baselayout-1.12.0_pre16' ; then
		ewarn "The best way of using this driver is through the pppd net module of"
		ewarn ">=sys-apps/baselayout-1.12.0_pre16, which is also the only"
		ewarn "documented mode of using ${CATEGORY}/${PN}."
		ewarn "Please install baselayout-1.12.0_pre16 or else you will be on your own!"
		ebeep
	fi
}

src_install() {
	local FILE_VER="${PV#*.}"
	FILE_VER="${PV%%.*}.${FILE_VER//./}"  # {major_ver}.{minor_digits}

	# Extract the "stage 1" portion of the firmware
	dd if=KQD6_${FILE_VER} of=speedtch-1.bin.2 \
		ibs=1 obs=991 count=991 skip=36 &> /dev/null \
		|| die "Extraction of stage 1 firmware (step 1) failed"

	dd if=ZZZL_${FILE_VER} of=speedtch-1.bin.4 \
		ibs=1 obs=935 count=935 skip=32 &> /dev/null \
		|| die "Extraction of stage 1 firmware (step 2) failed"

	# Extract the "stage 2" portion of the firmware
	dd if=KQD6_${FILE_VER} of=speedtch-2.bin.2 \
		ibs=1 obs=762650 count=762650 skip=1027 &> /dev/null \
		|| die "Extraction of stage 2 firmware (step 1) failed"

	dd if=ZZZL_${FILE_VER} of=speedtch-2.bin.4 \
		ibs=1 obs=775545 count=775545 skip=967 &> /dev/null \
		|| die "Extraction of stage 2 firmware (step 2) failed"

	# Copy to the firmware directory
	insinto /lib/firmware
	insopts -m 600
	doins speedtch-{1,2}.bin.{2,4} || die "doins firmware failed"

	# Symlinks for other revisions of the modem
	cd "${D}/lib/firmware"
	for n in 1 2 ; do
		for rev in 0 1 ; do
			ln -sfn speedtch-${n}.bin.2 speedtch-${n}.bin.${rev}
		done
		# Seems like a reasonable guess, for revision 3
		ln -sfn speedtch-${stub}${n}.bin.4 speedtch-${n}.bin.3
	done

	# Documentation necessary to complete the setup
	dodoc "${FILESDIR}/README" || die "dodoc failed"
}

pkg_postinst() {
	[[ -e /etc/hotplug/usb.usermap ]] && egrep -q " 0x06[bB]9 +0x4061 " /etc/hotplug/usb.usermap && \
		ewarn "Please remove the SpeedTouch line from /etc/hotplug/usb.usermap"

	# Check kernel configuration
	CONFIG_CHECK="~FW_LOADER ~NET ~PACKET ~ATM ~NETDEVICES ~USB_DEVICEFS ~USB_ATM ~USB_SPEEDTOUCH \
		~PPP ~PPPOATM ~PPPOE ~ATM_BR2684"
	check_extra_config
	einfo "Note: All the above kernel configurations are required except the following:"
	einfo "   - CONFIG_PPPOATM is needed only for PPPoA links, while"
	einfo "   - CONFIG_PPPOE and CONFIG_ATM_BR2684 are needed only for PPPoE links."
	echo

	# Check user space for PPPoA support
	if ! built_with_use net-dialup/ppp atm ; then
		eerror "PPPoA support: net-dialup/ppp should be built with 'atm' USE flag enabled!"
		ewarn "Run the following command if you need PPPoA support:"
		einfo "  euse -E atm && emerge net-dialup/ppp"
		echo
	fi
	# Check user space PPPoE support
	if ! has_version net-misc/br2684ctl ; then
		eerror "PPPoE support: net-misc/br2684ctl is not installed!"
		ewarn "Run the following command if you need PPPoE support:"
		einfo "   emerge net-misc/br2684ctl"
		echo
	fi

	ewarn "To complete the installation, you must read the documentation available in"
	ewarn "   ${ROOT}usr/share/doc/${PF}"
}
