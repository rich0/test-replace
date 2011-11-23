# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/vhba/vhba-1.2.1.ebuild,v 1.9 2011/11/23 09:40:00 tetromino Exp $

EAPI="2"

inherit linux-mod eutils

DESCRIPTION="Virtual (SCSI) Host Bus Adapter kernel module for the CDEmu suite"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/vhba-module-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND=""

S="${WORKDIR}/vhba-module-${PV}"
MODULE_NAMES="vhba(block:${S})"
BUILD_TARGETS="all"

pkg_setup() {
	CONFIG_CHECK="~BLK_DEV_SR ~CHR_DEV_SG"
	check_extra_config
	BUILD_PARAMS="KDIR=${KV_DIR}"
	linux-mod_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}/${PV}-parallel_build.patch" \
		"${FILESDIR}/${PV}-kerneldir.patch" \
		"${FILESDIR}/${P}-kernel-2.6.33.patch" \
		"${FILESDIR}/${P}-kernel-2.6.34.patch"
}

src_install() {
	KV_OBJ="ko"
	linux-mod_src_install || die "Error: installing module failed!"
	UDEV_RULES="/etc/udev/rules.d/70-vhba.rules"
	einfo "Generating UDEV-rules ..."
	mkdir -p "${D}"/${UDEV_RULES%/*}
	echo -e "# do not edit this file, it will be overwritten on update\n#" \
		> "${D}"/${UDEV_RULES}
	echo -e "KERNEL==\"vhba_ctl\", NAME=\"%k\", MODE=\"0660\", OWNER=\"root\",GROUP=\"cdemu\"" >> "${D}"/${UDEV_RULES}
}

pkg_postinst() {
	einfo "Generating cdemu group ..."
	enewgroup cdemu

	elog "Don't forget to add your user to the cdemu group "
	elog "if you want to be able to use virtual cdemu devices."
	linux-mod_pkg_postinst
}
