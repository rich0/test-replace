# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-5.5.ebuild,v 1.4 2004/03/22 04:08:29 vapier Exp $

inherit gcc eutils

DESCRIPTION="Utility to change hard drive performance parameters"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/hardware/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/hardware/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~ia64 mips ~ppc64 s390"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-5.4-readahead_rename.patch
	sed -i \
		-e "/^CC/s:gcc:$(gcc-getCC):" \
		-e "/^CFLAGS/s:-O2:${CFLAGS}:" \
		Makefile || die
}

src_compile() {
	emake || die "compile error"
}

src_install() {
	into /
	dosbin hdparm contrib/idectl

	exeinto /etc/init.d
	newexe ${FILESDIR}/hdparm-new-init hdparm

	insinto /etc/conf.d
	newins ${FILESDIR}/hdparm-conf.d hdparm

	doman hdparm.8
	dodoc hdparm.lsm Changelog README.acoustic hdparm-sysconfig
}

pkg_postinst() {
	einfo ""
	einfo "The rc-script for hdparm has been updated, so make sure "
	einfo "that you etc-update.  The script is much more configurable"
	einfo "for details please see /etc/conf.d/hdparm"
	einfo ""
}
