# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/i8kutils/i8kutils-1.17-r1.ebuild,v 1.1 2003/12/04 19:16:30 hanno Exp $

S=${WORKDIR}/${P}/
DESCRIPTION="Dell Inspiron and Latitude utilities"
SRC_URI="http://people.debian.org/~dz/i8k/${P}.tar.bz2"
HOMEPAGE="http://people.debian.org/~dz/i8k/"
DEPEND="virtual/glibc
	virtual/x11
	>=dev-lang/tk-8.3.3"
LICENSE="GPL-2"
SLOT="0"
IUSE="tcltk"
KEYWORDS="~x86 ~amd64 -mips"


src_compile() {
	local target="all"
	make ${target} || die
}

src_install() {
	dobin i8kbuttons i8kctl i8kfan i8kmon
	use tcltk && dobin i8kmon
	doman i8kbuttons.1 i8kctl.1
	use tcltk && doman i8kmon.1
	use tcltk && dosym /usr/bin/i8kctl /usr/bin/i8kfan
	dodoc README.i8kutils
	dodoc COPYING
	dodoc i8kmon.conf
	dodoc Configure.help.i8k
	docinto examples/
	dodoc examples/*

	insinto /etc/init.d
	newins ${FILESDIR}/i8k.init i8k
	fperms 755 /etc/init.d/i8k
	insinto /etc/conf.d
	newins ${FILESDIR}/i8k.conf i8k
}
